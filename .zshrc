# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Time load time with this command: time zsh -i -c exit

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

OS="$(uname 2> /dev/null)"

export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"

# =========================================================================================
### Added by Zinit's installer

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Plugins
# =========================================================================================
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
#zinit light-mode for \
#    zinit-zsh/z-a-rust \
#    zinit-zsh/z-a-as-monitor \
#    zinit-zsh/z-a-patch-dl \
#    zinit-zsh/z-a-bin-gem-node
zinit light zsh-users/zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="standout"

zinit light zsh-users/zsh-syntax-highlighting
    # Due to the following issue:
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/295
    # Syntax highlighting is really slow when pasting long text. This speeds it
    # up to just a slight delay
    zstyle ':bracketed-paste-magic' active-widgets '.self-*'

zinit ice atload"unalias grv"
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'

zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/ssh-agent/ssh-agent.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/vi-mode/vi-mode.plugin.zsh'

zinit light olets/zsh-window-title
export ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=1

# Homebrew
# =========================================================================================
case $OS in
  Darwin)
    eval "$(/opt/homebrew/bin/brew shellenv)"
  ;;
  Linux)
  ;;
esac

# Theme
# =========================================================================================

# Old "pure" theme
#------------------------------------------------------------------
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# see https://github.com/sindresorhus/pure for more colors
zstyle :prompt:pure:git:dirty color green

# Old Starship (slow)
#------------------------------------------------------------------

# Load starship
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

# Powerlevel 10k
#------------------------------------------------------------------
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# LS_COLORS
# =========================================================================================
export LS_COLORS="$(vivid generate 'modus-operandi')"

# Options section
# =========================================================================================
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt share_history                                            # Share history between tabs
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt promptsubst

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=500
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


# Keybindings section
# =========================================================================================
# enable vim mode
# https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
#export KEYTIMEOUT=50
export KEYTIMEOUT=1
# bindkey jk vi-cmd-mode

# change cursor shape
function zle-keymap-select zle-line-init zle-line-finish
{
  case $KEYMAP in
      vicmd)
          print -n '\033[1 q' # block cursor
          #echo -ne "\033]12;Green1\007"
      ;;
      viins|main)
          print -n '\033[5 q' # line cursor
          # echo -ne "\033]12;Orange1\007"
      ;;
  esac
}

# Yank to the system clipboard
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Paste from system clipboard
function pastefromclipboard {
  RBUFFER="$(pbpaste)$RBUFFER"
}

zle -N pastefromclipboard
bindkey -M vicmd 'p' pastefromclipboard

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select


# Note: see man zshzle for info on bindkey
# use kitty +kitten show_key to get the right UNIX escape sequence
case $OS in
  Darwin)
    bindkey '^[[1~' beginning-of-line # Home key
    bindkey '^[[4~' end-of-line       # End key
    bindkey '^[[3~' delete-char       # Delete key
    bindkey '^[[1;3C'  forward-word       # alt+Right key
    bindkey '^[f'  forward-word       # alt+f key
    bindkey '^[[1;3D'  backward-word      # alt+Left key
    bindkey '^[b'  backward-word      # alt+b key
    bindkey '^[[1;3A'  beginning-of-line  # alt+up key
    bindkey '^[[1~'  beginning-of-line  # home key
    bindkey '^[[1;3B'  end-of-line        # alt+down key
    bindkey '^[[4~'  end-of-line        # end key
    bindkey '^[^?'     backward-kill-word  # alt+bksp key
    bindkey '^[[3;3~'  kill-word         # alt+del key
        # bindkey '^H'  backward-kill-line         # cmd+bksp key, kitty does not differentiate between it and simple backspace 
        # bindkey '\x1b[3;9~'  kill-line         # cmd+del key, kitty does not differntiate between it and alt+del
  ;;
  Linux)
    bindkey '^[[3~' delete-char       # Delete key
    bindkey '^[[1;5C'  forward-word       # alt+Right key
    bindkey '^[[1;5D'  backward-word      # alt+Left key
    bindkey '^H'     backward-kill-word  # alt+bksp key
    bindkey '^[[3;5~'  kill-word         # alt+del key
  ;;
esac


## Plugins section: Enable fish style features
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Color man pages
# =========================================================================================
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# SAP connect to work
# =========================================================================================
[[ -e ~/.secret.zsh ]] && source ~/.secret.zsh
alias sapconnect="sudo f5fpc --start --host https://connectpal05.sap.com --user $SAP_USER"
#alias sapconnect="sudo f5fpc --start --host https://connectphl11.sap.com --user $SAP_USER"
alias sapinfo="sudo f5fpc --info"
alias sapstop="sudo f5fpc --stop"
# alias saprdp="xfreerdp /bpp:16 /u:$SAP_USER /d:GLOBAL /f /v:VANN34331165A.amer.global.corp.sap +clipboard +fonts +auto-reconnect -floatbar"
alias saprdp="xfreerdp /bpp:16 /u:$SAP_USER /d:GLOBAL /f /v:VANN34331165A.amer.global.corp.sap +clipboard +fonts +auto-reconnect +floatbar"


# some OS specific config
# =========================================================================================
case $OS in
  Darwin)
    export HOMEBREW_NO_GITHUB_API=1
    export HOMEBREW_NO_AUTO_UPDATE="1"
    export DISABLE_AUTO_TITLE='true' # for tmuxp
    export GROOVY_HOME=/usr/local/opt/groovy/libexec
    #export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
    #export JAVA_HOME="/usr/local/opt/openjdk@11"
    #export JAVA_HOME=$(/usr/libexec/java_home)
  ;;
  Linux)
  ;;
esac

# Version Management
# =========================================================================================

# fast node version manager
eval "$(fnm env --use-on-cd)"
# export FNM_DIR="/opt/repos/.fnm"

# yarn version management
export YVM_DIR=$HOME/.yvm
[ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh init-sh

#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# sdkman jdk managment
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# jvm version management
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init - --no-rehash)"
(jenv rehash &) 2> /dev/null
# makes sure JAVA_HOME is exported
eval "$(jenv enable-plugin export)"

export PATH="$HOME/.jenv/bin:$PATH"
#path=($HOME/.jenv/bin(N-/) $path) # path to jenv binary folder
if type jenv > /dev/null 2>&1; then
  zinit ice wait"0" lucid
  # zinit ice wait"0" lucid atload"jenv enable-plugin export"
  zinit light anquegi/zinit-jenv
fi

# EB vars
# =========================================================================================
export EB_FE_DEV_CERT_FILE="$HOME/certs/ebdev/eb-localdev.pem"

# Aliases
# =========================================================================================

alias vim="nvim"
alias xmdev="tmuxp load xmdev"
alias xmdev-cloud="tmuxp load xmdev-cloud"
alias xmdev-kill="confirm && tmux kill-session -t xmdev"
alias xmdev-cloud-kill="confirm && tmux kill-session -t xmdev-cloud"
alias devincloud="tmuxp load devincloud"
alias devincloud-kill="confirm && tmux kill-session -t devincloud"
# alias ls="ls -G"
alias ls="eza --icons=auto --width=80 --group-directories-first"
alias lst="colorls --light --tree"
alias git_cleanup_bugfix_branches="git branch | grep bugfix/ | xargs git branch -D"
alias git_cleanup_branches="git branch | grep -v '*' | grep -v 'master' | xargs git branch -D"

alias clean-gradle-cache="find ~/.gradle -type f -name \"*.lock\" -delete"
alias frontend-changed-strings="cd /opt/repos/frontend/reactUi/src/translations; git --no-pager diff --unified=0 origin/main:./en.json ./en.json | /usr/bin/sed '/^@/d' | /usr/bin/sed '/^\\+\\+\\+/d' | /usr/bin/sed '/^---/d' | /usr/bin/sed 's/^\\+  //'; cd -"
alias list_listening_procs="sudo lsof -iTCP -sTCP:LISTEN -n -P"
# note: config is in cypress.env.json
alias qa-automation-run-kramerica="yarn run cypress open --config baseUrl=https://kramerica.dev.xmatters.com --e2e --browser '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'"
alias yarn-test-changed="yarn run test --watch --changedSince=origin/main"
alias pnpm-test-changed="pnpm run test --watch --changedSince=origin/main"
alias ondemand-dev-in-cloud="cd /opt/repos/ondemand; ./gradlew bootRunDevInCloud -PgcpInstance=kramerica -Pversion=0.x.stephanlocal -PdevInCloud=true -PrunVoiceXml=false -PrunSoap=false -i"
alias ondemand-dev-in-cloud-stop="xmvers kramerica webui 0-x-main"
alias ebfd-ondemand-dev-in-cloud="cd /opt/repos/ondemand; ./gradlew bootRunDevInCloud -PgcpInstance=kramerica-ebfd -Pversion=0.x.stephanlocal -PdevInCloud=true -PrunVoiceXml=false -PrunSoap=false -i"
alias ebfd-ondemand-dev-in-cloud-stop="xmvers kramerica-ebfd webui 0-x-main"
alias ondemand-rebuild="cd /opt/repos/ondemand; ./gradlew clean build -x test -x analyzeClassesDependencies -x analyzeTestClassesDependencies"
alias ondemand-webui-integ-test="cd /opt/repos/ondemand; ./gradlew webui:integTest --tests " # param need, ex: com.xmatters.exportimport.RelevanceEngineImportHandlerIntegTest.testImportEngineWithIntegrationNoAuthType
alias ondemand-webui-integ-test-debug="cd /opt/repos/ondemand; ./gradlew webui:integTest --debug-jvm --tests " # listens to port 5005, param need, ex: com.xmatters.exportimport.RelevanceEngineImportHandlerIntegTest.testImportEngineWithIntegrationNoAuthType
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias qmk-flash-dactyl="qmk flash -kb handwired/dactyl_manuform/5x6 -km MagicDuck"
alias qmk-flash-cyboard="qmk flash -kb cyboard/dactyl/manuform_number_row -km sbadragan"
alias xmapi-dev-in-cloud="./gradlew  bootRunDevInCloud -PgcpInstance=kramerica -Pversion=0.x.kramerica -x test -x spotbugsTest -x spotbugsMain -x checkstyleTest -x checkstyleMain"
alias xmapi-dev-in-cloud-stop="xm-instance-switch-version kramerica xmapi 0-x-main"
alias showkey="kitty +kitten show_key"
alias gcloud-impersonate-start="gcloud config set auth/impersonate_service_account webui-dev@xmatters-eng-dev.iam.gserviceaccount.com"
alias gcloud-impersonate-stop="gcloud config unset auth/impersonate_service_account"
alias yadm-lazy='lazygit --use-config-file "$HOME/.config/yadm/lazygit.yml,$HOME/Library/Application Support/lazygit/config.yml" --work-tree ~ --git-dir ~/.local/share/yadm/repo.git'
alias my_conda_list_env="conda env list"
alias my_conda_activate="conda activate"


# FZF
# =========================================================================================

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --tiebreak=end --bind ctrl-a:toggle-all'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# gcloud
# =========================================================================================
case $OS in
  Darwin)
    source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  ;;
  Linux)
  ;;
esac

# pnpm
# =========================================================================================
# export PNPM_HOME="/Users/$HOME/Library/pnpm"
# export PATH="$PNPM_HOME:$PATH"

# BAT
# =========================================================================================

# export BAT_THEME='OneHalfLight'
# export BAT_THEME='Coldark-Cold'
# export BAT_THEME='GitHub'
export BAT_THEME='gruvbox-light'

# Git fuzzy
# =========================================================================================

export PATH=~/git-fuzzy/bin:$PATH

# Fix file limit exceeded issue
# =========================================================================================

ulimit -n 10240

# add gnu bin path for stuff like gnu-sed to override default sed
# =========================================================================================
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# ranger vim cursor support
# =========================================================================================
function ranger () { command ranger "$@"; echo -e "\e[?25h"; }

# miniconda python virtual env
# =========================================================================================
case $OS in
  Darwin)
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
    eval "$__conda_setup"
    else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
  fi
  unset __conda_setup
  ;;
  Linux)
  ;;
esac

# GO
# =========================================================================================
export PATH="$PATH:~/go/bin"

# Allows zsh -is eval "command" without exiting
# see https://www.zsh.org/mla/users/2005/msg00599.html
# =========================================================================================
if [[ $1 == eval ]]
then
  "$@"
  set --
fi

# [[ -z "${ZELLIJ}" ]] && zellij -l welcome

# certs
# =========================================================================================
case $OS in
  Darwin)
    export AWS_CA_BUNDLE=$HOME/zcc/certs/ZscalerRootCertificate-2048-SHA256.crt
    export REQUESTS_CA_BUNDLE=$HOME/zcc/certs/allCAbundle.pem
    export NODE_EXTRA_CA_CERTS=$HOME/zcc/certs/allCAbundle.pem
  ;;
  Linux)
  ;;
esac

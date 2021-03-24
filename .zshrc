# Time load time with this command: time zsh -i -c exit

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

OS="$(uname 2> /dev/null)"

export PATH="/usr/local/bin:$PATH"


# =========================================================================================
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk


# Plugins
# =========================================================================================
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
zinit light zsh-users/zsh-history-substring-search
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


# Theme
# =========================================================================================
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# see https://github.com/sindresorhus/pure for more colors
zstyle :prompt:pure:git:dirty color green

# LS_COLORS
export LS_COLORS="$(vivid generate 'ayu')"  

# Options section
# =========================================================================================
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
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
HISTSIZE=1000
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

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select


# TODO: prompt show status

# bindkey '^[[7~' beginning-of-line                               # Home key
# bindkey '^[[H' beginning-of-line                                # Home key
# if [[ "${terminfo[khome]}" != "" ]]; then
#   bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
# fi
# bindkey '^[[8~' end-of-line                                     # End key
# bindkey '^[[F' end-of-line                                     # End key
# if [[ "${terminfo[kend]}" != "" ]]; then
#   bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
# fi
# bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[1;3C'  forward-word                                    # Right key
bindkey '^[[1;3D'  backward-word                                   # Left key
# bindkey '^[[5~' history-beginning-search-backward               # Page up key
# bindkey '^[[6~' history-beginning-search-forward                # Page down key
#
# # Navigate words with ctrl+arrow keys
# bindkey '^[Oc' forward-word                                     #
# bindkey '^[Od' backward-word                                    #
# bindkey '^[[1;5D' backward-word                                 #
# bindkey '^[[1;5C' forward-word                                  #
# bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
# bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Plugins section: Enable fish style features
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
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
eval "$(fnm env)"

# yarn version management
export YVM_DIR=/Users/stephanbadragan/.yvm
[ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh init-sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# jvm version management
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init - --no-rehash)"
# (jenv rehash &) 2> /dev/null
# # makes sure JAVA_HOME is exported
# eval "$(jenv enable-plugin export)"

export PATH="$HOME/.jenv/bin:$PATH"
#path=($HOME/.jenv/bin(N-/) $path) # path to jenv binary folder
if type jenv > /dev/null 2>&1; then
  zinit ice wait"0" lucid
  # zinit ice wait"0" lucid atload"jenv enable-plugin export"
  zinit light anquegi/zinit-jenv
fi


# Aliases
# =========================================================================================

alias xmdev="tmuxp load xmdev"
alias xmdev-cloud="tmuxp load xmdev-cloud"
alias xmdev-kill="confirm && tmux kill-session -t xmdev"
alias xmdev-cloud-kill="confirm && tmux kill-session -t xmdev-cloud"
alias devincloud="tmuxp load devincloud"
alias devincloud-kill="confirm && tmux kill-session -t devincloud"
alias ls="ls -G"
alias lst="colorls --light --tree"
alias git_cleanup_bugfix_branches="git branch | grep bugfix/ | xargs git branch -D"
alias git_cleanup_branches="git branch | grep -v '*' | grep -v 'master' | xargs git branch -D"

alias clean-gradle-cache="find ~/.gradle -type f -name \"*.lock\" -delete"
alias ondemand-changed-strings="cd ~/ondemand/react/reactUi/src/translations; git --no-pager diff --unified=0 origin/master:./en.json ./en.json | sed '/^@/d' | sed '/^\\+\\+\\+/d' | sed '/^---/d' | sed 's/^\\+  //'; cd -"
alias list_listening_procs="sudo lsof -iTCP -sTCP:LISTEN -n -P"
alias qa-automation-run-local="yarn install && yarn run cypress open --config baseUrl=http://default.xmatters.com/ --env username=admin,password=complex,allure=false"
alias qa-automation-run-dev="yarn install && yarn run cypress open --config baseUrl=https://sbadragan.dev.xmatters.com/ --env username=admin,password=complex,allure=false"

alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"


# FZF
# =========================================================================================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --tiebreak=end --bind ctrl-a:toggle-all'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Git fuzzy
# =========================================================================================

export PATH=~/git-fuzzy/bin:$PATH

# Allows zsh -is eval "command" without exiting
# see https://www.zsh.org/mla/users/2005/msg00599.html
# =========================================================================================
if [[ $1 == eval ]]
then
  "$@"
  set --
fi


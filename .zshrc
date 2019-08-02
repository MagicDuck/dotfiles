[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

OS="$(uname 2> /dev/null)"

## package management
case $OS in
  Darwin)
    source /usr/local/share/antigen/antigen.zsh
  ;;
  Linux)
    source /usr/share/zsh/share/antigen.zsh
  ;;
esac

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle ssh-agent
antigen bundle vi-mode

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
    # Due to the following issue:
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/295
    # Syntax highlighting is really slow when pasting long text. This speeds it
    # up to just a slight delay
    zstyle ':bracketed-paste-magic' active-widgets '.self-*'

antigen bundle zsh-users/zsh-history-substring-search

# Load the theme.
# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=robbyrussell
{antigen list | grep $THEME} &>/dev/null; if [ $? -ne 0 ]; then antigen theme $THEME; fi

# Tell Antigen that you're done.
antigen apply

## Options section
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


## Keybindings section
# enable vim mode
# https://dougblack.io/words/zsh-vi-mode.html
# bindkey -v
#export KEYTIMEOUT=50
export KEYTIMEOUT=1
bindkey jk vi-cmd-mode

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
# bindkey '^[[C'  forward-word                                    # Right key
# bindkey '^[[D'  backward-word                                   # Left key
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

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

## Plugins section: Enable fish style features
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## Kittens aliases
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"

## connect to work
[[ -e ~/.secret.zsh ]] && source ~/.secret.zsh
alias sapconnect="sudo f5fpc --start --host https://connectpal05.sap.com --user $SAP_USER"
#alias sapconnect="sudo f5fpc --start --host https://connectphl11.sap.com --user $SAP_USER"
alias sapinfo="sudo f5fpc --info"
alias sapstop="sudo f5fpc --stop"
# alias saprdp="xfreerdp /bpp:16 /u:$SAP_USER /d:GLOBAL /f /v:VANN34331165A.amer.global.corp.sap +clipboard +fonts +auto-reconnect -floatbar"
alias saprdp="xfreerdp /bpp:16 /u:$SAP_USER /d:GLOBAL /f /v:VANN34331165A.amer.global.corp.sap +clipboard +fonts +auto-reconnect +floatbar"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"

unalias grv # to be able to use grv git client

# some OS specific config
case $OS in
  Darwin)
    export JAVA_HOME=$(/usr/libexec/java_home)
    export HOMEBREW_NO_GITHUB_API=1
    export DISABLE_AUTO_TITLE='true' # for tmuxp
  ;;
  Linux)
  ;;
esac

alias xmdev="tmuxp load xmdev"
alias xmdev-kill="confirm && tmux kill-session -t xmdev"
alias lst="colorls --light --tree"

# fzf opts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

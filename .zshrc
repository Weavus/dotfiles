# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export TERM="xterm-256color"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source iTerm2 shell integration
#if [[ -s "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh" ]]; then
#  source "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh"
#fi

# Add homebrew to the completion path
fpath=("/usr/local/bin/" $fpath)

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# This makes cd=pushd
setopt AUTO_PUSHD

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# No more annoying pushd messages...
# setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# this will ignore multiple directories for the stack.  Useful?  I dunno.
setopt PUSHD_IGNORE_DUPS

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT

# use magic (this is default, but it can't hurt!)
setopt ZLE

setopt NO_HUP

setopt IGNORE_EOF

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# Keep echo "station" > station from clobbering station
setopt NO_CLOBBER

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

setopt NO_CORRECT

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Incremental search is elite!
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# Search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

bindkey "\eOP" run-help

# oh wow!  This is killer...  try it!
bindkey -M vicmd "q" push-line

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

alias cd..='cd ..'
alias df='df -h'
alias du='du -h'
alias less='less -R'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias s='ssh'
alias d='kitty +kitten diff'
alias header='curl -I -s'
alias json='python -m json.tool'

alias dcup='docker-compose -f ~/Docker/docker-compose.yaml up -d' #brings up all containers if one is not defined after dcup
alias dcdown='docker-compose -f ~/Docker/docker-compose.yaml stop' #brings down all containers if one is not defined after dcdown
alias dcpull='docker-compose -f ~/Docker/docker-compose.yaml pull' #pulls all new images unless one is specified
alias dclogs='docker-compose -f ~/Docker/docker-compose.yaml logs -tf --tail="50" '
alias dcprune='docker image prune -f'
alias dctail='docker logs -tf --tail="50" "$@"'
alias dcupdate='dcdown; dcpull; dcup; dcprune'

if [[ "$OSTYPE" == darwin* ]]; then
  export EDITOR="code"
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  if ! type "hub" > /dev/null; then
    alias git='hub'
  fi
  alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
fi

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotp='dot push --set-upstream origin master'
alias dotc='dot commit -a'

if [[ -s "${ZDOTDIR:-$HOME}/.lscolors" ]]; then
  source "${ZDOTDIR:-$HOME}/.lscolors"
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

function refresh_ssh_autocomplete () {
    host_list=($(cat ~/.ssh/config ~/.ssh/infrastructure/* | grep -i 'Host ' | grep -v '\*' | awk '{s = s $2 " "} END {print s}'))
    # zstyle -e ':completion:*:(ssh|scp|sftp|rsync):*' 'reply=($host_list)'
    zstyle -e ':completion:*' hosts 'reply=($host_list)'
    # echo "SSH Refresh - ${host_list}"
}
refresh_ssh_autocomplete

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ "$OSTYPE" == linux-gnu ]]; then
  if [[ -s "/usr/bin/keychain" ]]; then
    /usr/bin/keychain --nogui $HOME/.ssh/id_refinitiv
    source $HOME/.keychain/Inferno-sh
  fi
fi

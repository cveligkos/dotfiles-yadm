# The following lines were added by compinstall

zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/christos/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=25000
SAVEHIST=25000
setopt nomatch
unsetopt beep autocd extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install

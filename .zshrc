# vim:fileencoding=utf-8:foldmethod=marker

# zinit {{{

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### End of Zinit's installer chunk
# }}}

# Powerlevel10k instant prompt {{{

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# }}}

# zsh settings {{{

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

HISTFILE=~/.zhistory
HISTSIZE=25000
SAVEHIST=25000
setopt nomatch
unsetopt beep autocd extendedglob notify
bindkey -v

# }}}

# aliases {{{

alias v='nvim'
alias t='task'
alias r='ranger'
alias lg='lazygit'

alias ls='exa'
alias la='exa -a'
alias ll='exa -l'
alias lla='exa -la'

alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gcl='git clone'

alias reload='source ~/.zshrc'

# }}}

# Powerlevel10k settings {{{

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# }}}

# zoxide {{{

eval "$(zoxide init zsh)"

# }}}

# volta {{{

export VOLTA_HOME="$HOME/.volta"
path=("$VOLTA_HOME/bin" $path)

# }}}

# path {{{

path=("$HOME/bin" $path)
typeset -U path

# }}}

# Env vars {{{

export EDITOR='nvim'

if [ -f ~/.env-vars ]; then
	source ~/.env-vars
fi

# }}}

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
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME

setopt nomatch
unsetopt beep autocd extendedglob notify
bindkey -e

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

bindkey '^J' vi-forward-blank-word
bindkey '^K' vi-backward-blank-word-end

bindkey '^[[3~' delete-char
bindkey '^[h' backward-delete-word
bindkey '^[[3;5~' delete-word

bindkey -s '^R' '$(cat $HISTFILE | sk)^M'

# }}}

# aliases {{{

alias v='nvim'
alias t='task'
alias r='ranger'
alias lg='lazygit'
alias pn='pnpm'

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

# skim {{{

#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.zsh
#
# - $SKIM_TMUX_OPTS
# - $SKIM_CTRL_T_COMMAND
# - $SKIM_CTRL_T_OPTS
# - $SKIM_CTRL_R_OPTS
# - $SKIM_ALT_C_COMMAND
# - $SKIM_ALT_C_OPTS

# Key bindings
# ------------

# The code at the top and the bottom of this file is the same as in completion.zsh.
# Refer to that file for explanation.
if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  __skim_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
else
  () {
    __skim_key_bindings_options="setopt"
    'local' '__skim_opt'
    for __skim_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__skim_opt" ]]; then
        __skim_key_bindings_options+=" -o $__skim_opt"
      else
        __skim_key_bindings_options+=" +o $__skim_opt"
      fi
    done
  }
fi

'emulate' 'zsh' '-o' 'no_aliases'

{

[[ -o interactive ]] || return 0

# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  local cmd="${SKIM_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  REPORTTIME_=$REPORTTIME
  unset REPORTTIME
  eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_CTRL_T_OPTS" $(__skimcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  if ! [ -z $REPORTTIME_ ]; then
      REPORTTIME=$REPORTTIME_
  fi
  unset REPORTTIME_
  return $ret
}

__skimcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${SKIM_TMUX:-0}" != 0 ] || [ -n "$SKIM_TMUX_OPTS" ]; } &&
    echo "sk-tmux ${SKIM_TMUX_OPTS:--d${SKIM_TMUX_HEIGHT:-40%}} -- " || echo "sk"
}

skim-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   skim-file-widget
bindkey '^T' skim-file-widget

# Ensure precmds are run after cd
skim-redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N skim-redraw-prompt

# ALT-C - cd into the selected directory
skim-cd-widget() {
  local cmd="${SKIM_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  REPORTTIME_=$REPORTTIME
  unset REPORTTIME
  local dir="$(eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_ALT_C_OPTS" $(__skimcmd) --no-multi)"
  if ! [ -z $REPORTTIME_ ]; then
      REPORTTIME=$REPORTTIME_
  fi
  unset REPORTTIME_
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  if [ -z "$BUFFER" ]; then
    BUFFER="cd ${(q)dir}"
    zle accept-line
  else
    print -sr "cd ${(q)dir}"
    cd "$dir"
  fi
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle skim-redraw-prompt
  return $ret
}
zle     -N    skim-cd-widget
bindkey '\ec' skim-cd-widget

# CTRL-R - Paste the selected command from history into the command line
skim-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} $SKIM_DEFAULT_OPTIONS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $SKIM_CTRL_R_OPTS --query=${(qqq)LBUFFER} --no-multi" $(__skimcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   skim-history-widget
bindkey '^R' skim-history-widget

} always {
  eval $__skim_key_bindings_options
  'unset' '__skim_key_bindings_options'
}

# }}}

# broot {{{

# This script was automatically generated by the broot program
# More information can be found in https://github.com/Canop/broot
# This function starts broot and executes the command
# it produces, if any.
# It's needed because some shell commands, like `cd`,
# have no useful effect if executed in a subshell.
function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        rm -f "$cmd_file"
        return "$code"
    fi
}

# }}}

# path {{{

typeset -U path

# }}}

# pyenv {{{

eval "$(pyenv init -)"

# }}}

FILES=(
    zinit
    powerlevel10k
    options
    aliases
    zoxide
    skim
    broot
    tabtab
    completion
    keybinds
    path
)

load () {
    source ~/.zshrc.d/$1.zsh
}

for file in $FILES; load $file





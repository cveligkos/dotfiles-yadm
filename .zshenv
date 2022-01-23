if command -v volta &> /dev/null
then
    export VOLTA_HOME="$HOME/.volta"
    path=("$VOLTA_HOME/bin" $path)
fi

if command -v cargo &> /dev/null
then
    path=("$HOME/.cargo/bin" $path)
fi

if command -v rbenv &> /dev/null
then
    path=("$HOME/.rbenv/bin" $path)
fi

if command -v go &> /dev/null
then
    path=("$HOME/go/bin" $path)
fi

path=("$HOME/bin" $path)

export PATH

if [[ $DESKTOP_SESSION == "awesome" ]]; then
    # Set Qt theme
    export QT_QPA_PLATFORMTHEME=qt5ct
fi

export TERMINAL=kitty
export EDITOR=nvim
export SYSTEMD_EDITOR=nvim
export BROWSER=firefox

# Use bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

if [ -f ~/.env-vars ]; then
    source ~/.env-vars
fi



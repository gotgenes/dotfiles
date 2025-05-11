if [[ -d "$HOME/.docker/bin" ]]; then
    export path=("$HOME/.docker/bin" $path)
fi

if [[ -v HOMEBREW_PREFIX ]]; then
    export path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
fi

if [[ -v GOPATH ]]; then
    export path=("$GOPATH/bin" $path)
fi

export path=("$HOME/.local/bin" $path)

typeset -aU path

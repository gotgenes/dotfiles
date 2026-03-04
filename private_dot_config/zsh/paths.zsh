if [[ -d "$HOME/.docker/bin" ]]; then
    export path=("$HOME/.docker/bin" $path)
fi

# Re-prepend homebrew ahead of system paths. brew shellenv adds these in .zshenv,
# but /etc/zprofile's path_helper demotes them behind system paths for login shells.
if [[ -v HOMEBREW_PREFIX ]]; then
    export path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
fi

if [[ -v GOPATH ]]; then
    export path=("$GOPATH/bin" $path)
fi

export path=("$HOME/.local/bin" $path)

typeset -aU path

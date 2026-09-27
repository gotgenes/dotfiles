# User PATH entries, prepended ahead of the system paths. Sourced twice for
# login shells: from .zshenv (so non-interactive login shells such as
# OpenCode's `zsh -l -c` get them) and again from .zshrc, because
# /etc/zprofile's path_helper runs between the two and demotes everything
# prepended here behind the system paths. bash's equivalent is
# ~/.config/bash/paths.bash.

if [[ -d "$HOME/.docker/bin" ]]; then
    export path=("$HOME/.docker/bin" $path)
fi

# Homebrew: the PATH half of `brew shellenv`. /etc/paths.d/homebrew also lists
# /opt/homebrew/bin, but path_helper puts it after /usr/bin, so system tools
# (e.g. /usr/bin/git) would otherwise shadow Homebrew's.
if [[ -v HOMEBREW_PREFIX ]]; then
    export path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
fi

if [[ -v GOPATH ]]; then
    export path=("$GOPATH/bin" $path)
fi

export path=("$HOME/.local/bin" $path)

# Deduplicate, then remove the permanent unique constraint so later
# re-prepends (e.g., mise shims after path_helper reorders) can move
# entries back to the front of PATH.
typeset -aU path
typeset +U path

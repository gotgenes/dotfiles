# User PATH entries, prepended ahead of the system paths: bash's equivalent of
# ~/.config/zsh/paths.zsh, producing the same order.
#
# Sourced from ~/.bash_profile for login shells. Unlike zsh, a single pass is
# enough: macOS's /etc/profile runs path_helper BEFORE ~/.bash_profile, so
# nothing reorders PATH after this runs. (In zsh, /etc/zprofile's path_helper
# runs between .zshenv and .zshrc, forcing a second pass.)
#
# Keep this bash 3.2 compatible (no associative arrays): /bin/bash is 3.2.

__paths_prepend() {
    PATH="$1${PATH:+:$PATH}"
}

if [[ -d "$HOME/.docker/bin" ]]; then
    __paths_prepend "$HOME/.docker/bin"
fi

# Homebrew: the PATH half of `brew shellenv`. /etc/paths.d/homebrew also lists
# /opt/homebrew/bin, but path_helper puts it after /usr/bin, so system tools
# (e.g. /usr/bin/git) would otherwise shadow Homebrew's.
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
    __paths_prepend "$HOMEBREW_PREFIX/sbin"
    __paths_prepend "$HOMEBREW_PREFIX/bin"
fi

if [[ -n "${GOPATH:-}" ]]; then
    __paths_prepend "$GOPATH/bin"
fi

__paths_prepend "$HOME/.local/bin"

# Deduplicate, keeping the first (highest-priority) occurrence. Empty entries
# are dropped: an empty PATH entry means "the current directory".
__paths_dedupe() {
    local entry deduped=""
    local -a entries
    IFS=: read -r -a entries <<< "$PATH"
    for entry in "${entries[@]}"; do
        [[ -n "$entry" ]] || continue
        case ":$deduped:" in
            *":$entry:"*) ;;
            *) deduped="${deduped:+$deduped:}$entry" ;;
        esac
    done
    PATH="$deduped"
}
__paths_dedupe

export PATH
unset -f __paths_prepend __paths_dedupe

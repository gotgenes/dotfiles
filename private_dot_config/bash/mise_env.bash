# Apply the current directory's mise.toml [env] vars as DEFAULTS: any var
# already in the environment (inherited from the parent process, or an inline
# override such as `AWS_PROFILE=x cmd`) is left alone. PATH is not touched:
# the inherited PATH is already correct, and mise shims resolve tool versions
# per directory at run time.
#
# Why this exists: `bash -c` (how Pi runs every command) reads no startup files
# at all, so nothing would otherwise apply mise.toml env vars for the directory
# a command runs in. Pi sources this file before each command via
# ~/.pi/agent/settings.json:
#
#   "shellPath": "/opt/homebrew/bin/bash",
#   "shellCommandPrefix": "source ~/.config/bash/mise_env.bash"
#
# Also sourced by ~/.bash_profile for non-interactive login shells.
# zsh's equivalent is the mise block in ~/.config/zsh/.zshenv.
#
# This runs inside the caller's shell, so everything is function-local and the
# function is removed afterwards.

__mise_env_defaults() {
    local mise_bin line rest var
    # Fall back to the Homebrew path in case the inherited PATH is bare.
    mise_bin="$(command -v mise)" || mise_bin="${HOMEBREW_PREFIX:-/opt/homebrew}/bin/mise"
    [[ -x "$mise_bin" ]] || return 0

    while IFS= read -r line; do
        [[ "$line" == "export "* && "$line" != "export PATH="* ]] || continue
        rest="${line#export }"
        var="${rest%%=*}"
        [[ "$var" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] || continue
        # `mise env -s bash` shell-quotes values, so eval is safe here.
        if [[ -z "${!var+x}" ]]; then
            eval "export $rest"
        fi
    done < <("$mise_bin" env -s bash 2>/dev/null)
    return 0
}

__mise_env_defaults
unset -f __mise_env_defaults

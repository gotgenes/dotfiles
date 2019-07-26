source_if_exists () {
    file_to_source="$1"
    if [[ -r "$file_to_source" ]]; then
        source "$file_to_source"
    fi
}

export -f source_if_exists

# Set the number of lines to be recorded in the history
export HISTSIZE=100000

# Remove duplicate lines in the history, and ignore any lines that begin
# with a space. See bash(1) for more options.
export HISTCONTROL=erasedups:ignorespace

# Bash completion
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"


# Use Neovim as the default editor.
export EDITOR="nvim"

# HOMEBREW
# Prioritize /usr/local/bin for Homebrew
export PATH=$(echo ${PATH} | awk -v RS=: -v ORS=: '/usr\/local\/bin/ {next} {print}' | sed 's/:*$//')
export PATH="/usr/local/bin:${PATH}"


# Local installations
LOCAL_DIR="$HOME/.local"
# Local executables
export PATH="$LOCAL_DIR/bin:$PATH"

source_if_exists "$NVM_DIR/bash_completion"

# Custom Python interactive session configuration.
export PYTHONSTARTUP="$HOME/.pythonrc"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    export -f pyenv
fi

# rvm
export PATH="$PATH:$HOME/.rvm/bin"
source_if_exists "$HOME/.rvm/scripts/rvm"

# NVM
export NVM_DIR="$HOME/.nvm"

source_if_exists "$HOME/.iterm2_shell_integration.bash"

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

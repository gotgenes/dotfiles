# BASH BEHAVIOR

# I like to use Vim type editing of the command line, comment out
# everything below if you prefer the default Emacs-style editing.
set -o vi
# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history

# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete

# ^l clear screen
bind -m vi-insert "\C-l":clear-screen

# ^b back a word
bind -m vi-insert "\C-\e[C":backward-word

# ^f forward a word
bind -m vi-insert "\C-\e[D":forward-word

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append history, don't overwrite it--very handy when working with
# multiple shells, as closing the last one won't blow away the history
# of the previous session.
shopt -s histappend

# Bash aliases
source_if_exists "$HOME/.bash_aliases"

# Bash prompt
case "$TERM" in
xterm*|rxvt*|gnome*|screen-256color)
    source_if_exists "$HOME/.bash_prompt"
    ;;
*)
    source_if_exists "$HOME/.bash_prompt_alt"
    ;;
esac

export NVM_HOMEBREW_DIR="$(brew --prefix)/opt/nvm"
source_if_exists "$NVM_HOMEBREW_DIR/nvm.sh"

bash_completion_script="$(brew --prefix)/etc/profile.d/bash_completion.sh"
if [[ -r "$bash_completion_script" ]]; then
    source "$bash_completion_script"
    # Disable tilde expansion; see
    # http://superuser.com/questions/95653/bash-shell-tab-completion-dont-expand-the
    _expand()
    {
        return 0
    }
    __expand_tilde_by_ref()
    {
        return 0
    }
fi

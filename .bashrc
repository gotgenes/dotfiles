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

# Remove duplicate lines in the history, and ignore any lines that begin
# with a space. See bash(1) for more options.
export HISTCONTROL=erasedups:ignorespace

# Append history, don't overwrite it--very handy when working with
# multiple shells, as closing the last one won't blow away the history
# of the previous session.
shopt -s histappend

# Set the number of lines to be recorded in the history
export HISTSIZE=100000

# Logic for setting the TERM variable correctly (GNOME Terminal sets
# this incorrectly).
# Obtained from http://vim.wikia.com/wiki/256_colors_in_vim
if [ "$TERM" = "xterm" ] ; then
    if [ -z "$COLORTERM" ] ; then
        if [ -z "$XTERM_VERSION" ] ; then
            echo "Warning: Terminal wrongly calling itself 'xterm'."
        else
            case "$XTERM_VERSION" in
            "XTerm(256)") TERM="xterm-256color" ;;
            "XTerm(88)") TERM="xterm-88color" ;;
            "XTerm") ;;
            *)
                echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION"
                ;;
            esac
        fi
    else
        case "$COLORTERM" in
            gnome-terminal)
                # Those crafty Gnome folks require you to check COLORTERM,
                # but don't allow you to just *favor* the setting over TERM.
                # Instead you need to compare it and perform some guesses
                # based upon the value. This is, perhaps, too simplistic.
                TERM="gnome-256color"
                ;;
            *)
                echo "Warning: Unrecognized COLORTERM: $COLORTERM"
                ;;
        esac
    fi
fi

# Use Vim as the default editor.
export EDITOR="mvim -v"


source_if_exists () {
    file_to_source="$1"
    if [ -f $file_to_source ]; then
        . $file_to_source
    fi
}

# Bash aliases
source_if_exists "$HOME/.bash_aliases"

# Bash completion
source_if_exists "$(brew --prefix)/etc/bash_completion"
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
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

# Bash prompt
case "$TERM" in
xterm*|rxvt*|gnome*|screen-256color)
    source_if_exists "$HOME/.bash_prompt"
    ;;
*)
    source_if_exists "$HOME/.bash_prompt_alt"
    ;;
esac



# LOCALE PREFERENCES
export LC_ALL="en_US.UTF-8"
# I prefer 24-hour clocks and YYYY-MM-DD date format.
export LC_TIME="en_DK.UTF-8"


# HOMEBREW
# Prioritize /usr/local/bin for Homebrew
export PATH=$(echo ${PATH} | awk -v RS=: -v ORS=: '/usr\/local\/bin/ {next} {print}' | sed 's/:*$//')
export PATH="/usr/local/bin:${PATH}"


# LOCALLY-INSTALLED SOFTWARE
# For software installation, compilation, etc. without needing
# administrator priveleges.

LOCAL_DIR="$HOME/.local"

# Local executables
export PATH="$LOCAL_DIR/bin:$PATH"

# Local libraries
LOCAL_LIB_DIR="$LOCAL_DIR/lib"
export LIBRARY_PATH="$LOCAL_LIB_DIR:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$LOCAL_LIB_DIR:$LD_LIBRARY_PATH"
export LD_RUN_PATH="$LOCAL_LIB_DIR:$LD_RUN_PATH"
export CPATH="$LOCAL_LIB_DIR/include:$CPATH"

export PKG_CONFIG_PATH="$LOCAL_LIB_DIR/pkgconfig:/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# Local man pages
export MANPATH="$LOCAL_DIR/share/man:$MANPATH"

# Locally installed LaTeX files
export TEXMFHOME="$HOME/texmf"

# Perl module installations should be through local::lib, which should
# be set up with the root as ~/.local. This line puts those modules on
# the PERL5LIB path.
# Disabled for plenv.
#eval $(perl -I$LOCAL_LIB_DIR/perl5 -Mlocal::lib=$LOCAL_DIR)


# Ruby gems install locally.
export GEM_HOME="$LOCAL_DIR"
export GEM_PATH="$GEM_HOME:$GEM_PATH"
export RUBYLIB="$GEM_HOME/lib:$RUBY_LIB"


# APPLICATION ENVIRONMENTAL VARIABLES

# enable color support of ls and other programs
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# PYTHON ENVIRONMENT

# Custom Python interactive session configuration.
export PYTHONSTARTUP="$HOME/.pythonrc"

# virtualenvwrapper customization
export WORKON_HOME="$HOME/.virtualenvs"
source_if_exists /usr/local/bin/virtualenvwrapper.sh

# pyenv and plenv setup
init_xenv() {
    xenv=$1
    if [ -d $HOME/.$xenv/bin ]; then
        export PATH="$HOME/.$xenv/bin:$PATH"
    fi
    if command -v $xenv >/dev/null 2>&1; then
        eval "$($xenv init -)"
        source_if_exists "$HOME/.$xenv/completions/$xenv.bash"
    fi
}

init_xenv 'pyenv'
init_xenv 'plenv'


# Docker support
connect_to_docker() {
    if [ "$(boot2docker status)" = 'running' ]; then
        eval "$(boot2docker shellinit 2>/dev/null)"
    fi
}

if which boot2docker >/dev/null; then
    connect_to_docker
fi

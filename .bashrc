# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


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


# ALIAS DEFINITIONS
#
# Aliases which I find universally handy go here; aliases which are
# machine-specific should be specified in a separate ~/.bash_aliases
# file (see below).

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias lr='ls -R'
alias lla='ls -lA'
alias llh='ls -lh'
alias llr='ls -lR'
alias llar='ls -lAR'
#alias l='ls -CF'

# Additional aliases.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# BASH COMPLETION.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    # I hate tilde expansion, so I'm overriding the stupid expand
    # functions for it.
    _expand()
    {
        return 0
    }
    __expand_tilde_by_ref()
    {
        return 0
    }
fi

# Remove duplicate lines in the history, and ignore any lines that begin
# with a space. See bash(1) for more options.
export HISTCONTROL=erasedups:ignorespace

# Append history, don't overwrite it--very handy when working with
# multiple shells, as closing the last one won't blow away the history
# of the previous session.
shopt -s histappend

# Set the number of lines to be recorded in the history
export HISTSIZE=5000

# Locally installed LaTeX junk goes in your ~/texmf directory
export TEXMFHOME=$HOME/texmf

# Need to set default locale
export LC_ALL="en_US.UTF-8"

# I prefer 24-hour clocks and YYYY-MM-DD date format.
export LC_TIME="en_DK.UTF-8"

# USER-INSTALLED SOFTWARE
# User's executables
PATH=~/.local/bin:"${PATH}"

# Local libraries
export LIBRARY_PATH=~/.local/lib:"${LIBRARY_PATH}"
export LD_LIBRARY_PATH=~/.local/lib:"${LD_LIBRARY_PATH}"
export LD_RUN_PATH=~/.local/lib:"${LD_RUN_PATH}"
export CPATH=~/.local/include:"${CPATH}"

export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Custom man pages
export MANPATH="$HOME/.local/share/man:$MANPATH"

# Custom Python interactive session configuration.
export PYTHONSTARTUP="$HOME/.pythonrc"

# Perl module installations should be through local::lib, which should
# be set up with the root as ~/.local. This line puts those modules on
# the PERL5LIB path.
eval $(perl -I$HOME/.local/lib/perl5 -Mlocal::lib=$HOME/.local)


# EDITOR CONFIGURATION
# I like to use Vim as my default editor. Replace with your editor of
# preference.
export EDITOR="vim"


# PROMPT_CONFIGURATION
# Use my custom prompt, if it exists.
case "$TERM" in
xterm*|rxvt*|gnome*|screen-256color)
    if [ -f ~/.bash_prompt ]; then
        source ~/.bash_prompt
    fi
    ;;
*)
    if [ -f ~/.bash_prompt_alt ]; then
        source ~/.bash_prompt_alt
    fi
    ;;
esac


# SHELL BEHAVIOR
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


# APPLICATION ENVIRONMENTAL VARIABLES
# Amazon Web Services shizzle
export EC2_PRIVATE_KEY=$HOME/.aws/pk-CVOZOBWUHLG5QUKSXTEYV6KG6TY4LRMW.pem
export EC2_CERT=$HOME/.aws/cert-CVOZOBWUHLG5QUKSXTEYV6KG6TY4LRMW.pem
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/

# virtualenvwrapper customization
export WORKON_HOME=$HOME/.virtualenvs
if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

# let pip know about virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME


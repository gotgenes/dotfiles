# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=erasedups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    # I hate tilde expansion, so I'm overriding the stupid expand
    # function for it
    _expand()
    {
        return 0
    }
fi

# append history, don't overwrite it--very handy when working with multiple
# shells, as closing the last one won't blow away the history of the previous
# session.
shopt -s histappend
# set the number of lines to be recorded in the history; monitor your activity
# and adjust periodically; right now this seems no get me enough for a month
# of history provided the 'histcontrol=ignoredups' is set (see above) and more
# if 'histcontrol=erasedups' is set.
export HISTSIZE=2500

# Locally installed LaTeX junk goes in your ~/texmf directory
export TEXMFHOME=$HOME/texmf

export LC_TIME="en_DK.UTF8"

# I like to use Vim as my default editor. Replace with your editor of
# preference.
# If we're running in a GUI environment or with ssh -X, I want gVim
if [[ $DISPLAY ]] && [ -x /usr/bin/gvim ]; then
    export EDITOR="gvim -f"
# otherwise, give me plain old Vim
else
    export EDITOR="vim"
fi

# Use my custom prompt, if it exists.
case "$TERM" in
xterm*|rxvt*)
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

# Custom Python interactive session configuration.
export PYTHONSTARTUP="$HOME/.pythonrc"

# Custom Perl modules installed in the following
export PERL5LIB="$HOME/.local/lib/perl5:$HOME/.local/lib/murali_modules"

# Custom executables
export PATH="$HOME/.local/bin:$PATH"

# Custom man pages
export MANPATH="$HOME/.local/share/man:$MANPATH"

# Amazon Web Services shizzle
export EC2_PRIVATE_KEY=$HOME/.ec2/pk-CVOZOBWUHLG5QUKSXTEYV6KG6TY4LRMW.pem
export EC2_CERT=$HOME/.ec2/cert-CVOZOBWUHLG5QUKSXTEYV6KG6TY4LRMW.pem
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/

# virtualenvwrapper customization
export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.virtualenvwrapper_bashrc

# let pip know about virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME


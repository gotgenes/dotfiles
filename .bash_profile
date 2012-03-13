# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d ~/.local/bin ] ; then
    PATH=~/.local/bin:"${PATH}"
fi

# set path to local libraries
if [ -d ~/.local/bin ]; then
    LD_LIBRARY_PATH=~/.local/lib:"${LD_LIBRARY_PATH}"
    LD_RUN_PATH=~/.local/lib:"${LD_RUN_PATH}"
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


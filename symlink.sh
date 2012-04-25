#!/bin/bash
# A simple script to symlink configuration files to the home directory.

set -e

# Add files that should not be symlinked to the array below.
DO_NOT_SYMLINK=( '.git' '.gitignore' 'README.rst' 'symlink.sh' )

# The directory in which this script exists. See
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Adapted from http://stackoverflow.com/a/8574392/38140
in_array() { for e in "${@:2}"; do [[ "$e" = "$1" ]] && break; done; }

ln_flags="-sn"

while getopts "f" OPTION; do
    case "$OPTION" in
        f)
            ln_flags="${ln_flags}f"
            force=1
        ;;
        *)
            exit 1
        ;;
    esac
done

for file in `ls -A $DIR`; do
    path="$DIR/$file"
    if ( in_array "$file" "${DO_NOT_SYMLINK[@]}" ); then
        echo "Ignoring $file"
    else
        newpath="$HOME/$file"
        if [[ -e $newpath ]] && [[ $force != 1 ]]; then
            echo "Skipping $file because it exists already (maybe try using -f)"
        else
            echo "Creating symlink $newpath"
    	    ln $ln_flags $DIR/$file $HOME
        fi
    fi
done

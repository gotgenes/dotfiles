#!/bin/bash
# A simple script to symlink configuration files to the home directory.

set -e

# Add files that should not be symlinked to the array below.
DO_NOT_SYMLINK=( '.git' '.gitignore' 'README.rst' 'symlink.sh' )
# Add files that should be handled specially to the array below.
SPECIAL_CASES=( '.config' )

skip=( "${DO_NOT_SYMLINK[@]}" "${SPECIAL_CASES[@]}" )

# The directory in which this script exists. See
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Adapted from http://stackoverflow.com/a/8574392/38140
in_array() { for e in "${@:2}"; do [[ "$e" = "$1" ]] && break; done; }

symlink() {
    origin_dir="$1"
    destination_dir="$2"

    mkdir -p "$destination_dir"

    for file in $(ls -A $origin_dir); do
        path="$origin_dir/$file"
        if ( in_array "$file" "${skip[@]}" ); then
            echo "Ignoring $file"
        else
            newpath="$destination_dir/$file"
            if [[ -e $newpath ]] && [[ $force != 1 ]]; then
                echo "Skipping $file because $newpath exists already (maybe try using -f)"
            else
                echo "Creating symlink $newpath"
                ln "$ln_flags" "$path" "$newpath"
            fi
        fi
    done
}

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

symlink "$DIR" "$HOME"
symlink "$DIR/.config" "$HOME/.config"

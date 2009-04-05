#!/bin/bash
# A simple script to symlink configuration files to the home directory.
# BE ADVISED: You must execute this script from within the directory it's in
# e.g., /home/user/shell-configs/symlink.sh means you should cd into
# /home/user/shell-configs/ before executing it.

while getopts "f" OPTION; do
    case $OPTION in
        "f" )
            echo "Found option f"
            flags="-sf"
        ;;
    esac
done

if [[ ! -n "$FLAGS" ]]; then
    flags="-s"
fi

for file in `ls -A`; do
    case $file in
        ".bzr" | "symlink.sh" )
            echo "Skipping $file"
        ;;
	* )
            echo "Creating symlink to $file"
	    ln $flags $PWD/$file ~
	;;
    esac
done

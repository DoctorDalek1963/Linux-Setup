#!/bin/bash

# Regex to check user input
yn_regex='^[Yy].*'

# Function to optionally copy a file (takes one argument; returns 0 if successful and 1 if unsuccessful, and 2 if not copied)
OptionalCopy() {
    read -p "Would you like to copy $1 to your home directory? (Y/n) " copy_var

    if [[ $copy_var =~ $yn_regex ]]
    then
        cp $1 ~ && echo "$1 copied";return 0 || echo "$1 failed to copy";return 1
    else
        echo "$1 not copied";return 2
    fi
}

# Copy the .vimrc and .bash_aliases to the home directory
cp .vimrc ~
echo ".vimrc copied"
cp .bash_aliases ~
echo ".bash_aliases copied"
source ~/.bash_aliases
echo ".bash_aliases sourced"

echo

# Copy .bashrc and if successful, source it
OptionalCopy .bashrc
if [[ $? -eq 0 ]]
then
    source ~/.bashrc && echo ".bashrc sourced"
fi

echo

OptionalCopy .gitconfig

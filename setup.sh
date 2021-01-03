#!/bin/bash

# Regex to check user input
yn_regex='^[Yy].*'

# Function to optionally copy a file (takes one argument; returns 0 if successful, 1 if unsuccessful, and 2 if not copied)
OptionalCopy() {
    echo # Create a blank line to pad things out a bit
    read -p "Would you like to copy $1 to your home directory? (Y/n) " copy_var

    if [[ $copy_var =~ $yn_regex ]]
    then
        cp $1 ~ && echo "$1 copied";return 0 || echo "$1 failed to copy";return 1
    else
        echo "$1 not copied";return 2
    fi
}

# Warn the user before doing anything
echo "WARNING: This will overwrite your ~/.vimrc and ~/.bash_aliases files automatically, with the option to overwrite your ~/.bashrc and ~/.gitconfig files"
read -p "Would you like to continue? (Y/n) " continue_var

if [[ ! $continue_var =~ $yn_regex ]] # If not continue, quit script
then
    exit 0 # Exit successfully
fi

echo

# Copy the .vimrc and .bash_aliases to the home directory
cp .vimrc ~
echo ".vimrc copied"
cp .bash_aliases ~
echo ".bash_aliases copied"
source ~/.bash_aliases
echo ".bash_aliases sourced"

# Copy .bashrc and if successful, source it
OptionalCopy .bashrc

if [[ $? -eq 0 ]]
then
    source ~/.bashrc && echo ".bashrc sourced"
fi

# Copy .gitconfig
OptionalCopy .gitconfig

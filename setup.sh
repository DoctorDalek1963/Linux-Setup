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

OptionalCopyAndSource () {
    # I just copied the whole OptionalCopy function in here because calling the function didn't seem to work
    echo # Create a blank line to pad things out a bit
    read -p "Would you like to copy $1 to your home directory? (Y/n) " copy_var

    if [[ $copy_var =~ $yn_regex ]]
    then
        cp $1 ~ && echo "$1 copied";source_var=true || echo "$1 failed to copy";success_var=false
    else
        echo "$1 not copied";source_var=false
    fi

    if $source_var ; then
        source ~/$1 && echo "$1 sourced" || echo "$1 failed to source"
    fi
}

# Warn the user before doing anything
echo "WARNING: This will optionally overwrite your ~/.vimrc, ~/.bash_aliases, ~/.bashrc, and ~/.gitconfig files"
read -p "Would you like to continue? (Y/n) " continue_var

if [[ ! $continue_var =~ $yn_regex ]] # If not continue, quit script
then
    exit 0 # Exit successfully
fi

OptionalCopy .vimrc

OptionalCopyAndSource .bash_aliases

OptionalCopyAndSource .bashrc

OptionalCopy .gitconfig

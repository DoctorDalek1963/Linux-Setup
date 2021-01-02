#!/bin/bash

# Copy the .vimrc and .bash_aliases to the home directory
cp .vimrc ~
echo ".vimrc copied"
cp .bash_aliases ~
echo ".bash_aliases copied"
source ~/.bash_aliases
echo ".bash_aliases sourced"

read -p "Would you like to copy .bashrc to your home directory? (Y/n) " bashrc_copy_var

yn_regex='^[Yy].*'

if [[ $bashrc_copy_var =~ $yn_regex ]]
then
    cp .bashrc ~
    echo ".bashrc copied"
    source ~/.bashrc
    echo ".bashrc sourced"
else
    echo ".bashrc not copied"
fi

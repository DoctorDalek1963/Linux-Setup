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
    # I just copied the whole OptionalCopy function in here (with minor alterations) because calling the function didn't seem to work
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

########## USER INTERACTION ##########

# Warn the user before doing anything
echo "WARNING: This script has options to overwrite important files and install lots of stuff, which will take time and bandwidth."
read -p "Would you like to continue? (Y/n) " continue_var

if [[ ! $continue_var =~ $yn_regex ]] # If not continue, quit script
then
    exit 0 # Exit successfully
fi

echo
echo "========== FILE MOVEMENT =========="

OptionalCopy .vimrc

OptionalCopyAndSource .bash_aliases

OptionalCopyAndSource .bashrc

OptionalCopy .gitconfig

echo
echo "========== VIM PLUGINS =========="
echo
echo "NOTE: If you don't install vim-plug and Vundle but you do copy .vimrc, the plugins won't load"
echo

read -p "Would you like to install vim-plug? (Y/n) " vim_plug_var

if [[ $vim_plug_var =~ $yn_regex ]]
then
    # Install curl if it's not already installed
    sudo apt -y install curl
    # Install vim-plug in autoload directory
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo

read -p "Would you like to install and update all vim-plug plugins? (Y/n) " vim_plug_install_var

if [[ $vim_plug_install_var =~ $yn_regex ]]
then
    vim -c "PlugInstall" -c "qa!"
    vim -c "PlugUpdate" -c "qa!"
fi
echo

read -p "Would you like to install Vundle? (Y/n) " vundle_var

if [[ $vundle_var =~ $yn_regex ]]
then
    # Clone github repo for Vundle into proper directory
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
echo

read -p "Would you like to install all depenedencies for the YouCompleteMe plugin (this will take a long time)? (Y/n) " ycm_var

if [[ $ycm_var =~ $yn_regex ]]
then
    sudo apt -y install build-essential cmake vim-nox python3-dev
    sudo apt -y install mono-complete golang nodejs default-jdk npm
    python3 ~/.vim/bundle/YouCompleteMe/install.py --all
fi
echo

read -p "Would you like to install and update all Vundle plugins? (Y/n) " vundle_install_var

if [[ $vundle_install_var =~ $yn_regex ]]
then
    vim -c "PluginInstall" -c "qa!"
    vim -c "PluginUpdate" -c "qa!"
fi
echo

echo "Thanks for using this setup utility!"
read -n 1 -s -r -p "Press any key to exit..."
echo

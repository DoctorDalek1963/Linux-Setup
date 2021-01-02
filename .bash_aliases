# Variable that holds the directory of the git repo holding this file and its associates
git_repo="~/repos/Linux-Setup"

# Deal with ~/.vimrc in single commands
alias upvrc="cp ~/.vimrc $git_repo/.vimrc && echo \~/.vimrc updated in git repo"
alias vvrc="vim ~/.vimrc"

# Deal with ~/.bash_aliases in single commands
alias srcbal="source ~/.bash_aliases && echo \~/.bash_aliases sourced"
alias upbal="cp ~/.bash_aliases $git_repo/.bash_aliases && echo \~/.bash_aliases updated in git repo"
alias vbal="vim ~/.bash_aliases"

# Deal with ~/.bashrc in single commands
alias srcbrc="source ~/.bashrc && echo \~/.bashrc sourced"
alias upbrc="cp ~/.bashrc $git_repo/.bashrc && echo \~/.bashrc updated in git repo"
alias vbrc="vim ~/.bashrc"

# Source and update ~/.vimrc, ~/.bashrc, and ~/,bash_aliases
alias srcupall="upvrc;srcbal;upbal;srcbrc;upbrc && echo;echo Everything sourced and updated"

# Update and upgrade apt and apt-get libraries
alias suaptup="sudo apt update;echo;sudo apt upgrade;echo;sudo apt-get update;echo;sudo apt-get upgrade;echo && echo apt and apt-get updated and upgraded"

# Echo my public IP address from ipinfo.io/ip
alias myip="curl ipinfo.io/ip;echo"

# Make a directory and cd into it
mkcd () {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Run ssh-agent and add the github_main private key to it
alias addghssh="eval \"\$(ssh-agent -s)\";ssh-add ~/.ssh/github_main"

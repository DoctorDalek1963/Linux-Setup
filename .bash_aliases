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

# Deal with ~/.gitconfig in single commands
alias upgc="cp ~/.gitconfig $git_repo/.gitconfig && echo \~/.gitconfig updated in git repo"
alias vgc="vim ~/.gitconfig"

# Source and update ~/.vimrc, ~/.bashrc, ~/,bash_aliases, and ~/.gitconfig
alias srcupall="upvrc;srcbal;upbal;srcbrc;upbrc;upgc;echo;echo Everything sourced and updated"
alias srcall="srcbal;srcbrc;echo;echo Everything sourced"
alias upall="upvrc;upbal;upbrc;upgc;echo;echo Everything updated"

alias fullsrcup="srcupall;srcupall" # Do it twice just to be sure

# Update and upgrade apt and apt-get libraries
alias suaptup="sudo apt -y update;echo;sudo apt -y upgrade;echo;sudo apt-get -y update;echo;sudo apt-get -y upgrade;sudo apt autoremove;sudo apt-get autoremove;echo;echo apt and apt-get updated and upgraded"

# Echo my public IP address from ipinfo.io/ip
alias myip="curl ipinfo.io/ip;echo"

# Make a directory and cd into it
mkcd () {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Run ssh-agent and add the github_main private key to it
alias addghssh="eval \"\$(ssh-agent -s)\";ssh-add ~/.ssh/github_main"

# Ease of use pip (literally the laziest thing I've ever done)
alias pip="pip3"

alias gp="git push"

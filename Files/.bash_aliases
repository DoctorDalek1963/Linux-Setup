alias x="exit"
alias c="clear"
alias v="vim"
alias g="git"

# Variable that holds the directory of the git repo holding this file and its associates
git_repo="~/repos/Linux-Setup/Files"

# Deal with ~/.vimrc in single commands
alias upvrc="cp ~/.vimrc $git_repo && echo \~/.vimrc updated in git repo"
alias vvrc="vim ~/.vimrc"

# Deal with ~/.ideavimrc in single commands
alias upivrc="cp ~/.ideavimrc $git_repo && echo \~/.ideavimrc updated in git repo"
alias vivrc="vim ~/.ideavimrc"

# Deal with ~/.bash_aliases in single commands
alias srcbal="source ~/.bash_aliases && echo \~/.bash_aliases sourced"
alias upbal="cp ~/.bash_aliases $git_repo && echo \~/.bash_aliases updated in git repo"
alias vbal="vim ~/.bash_aliases"

# Deal with ~/.bashrc in single commands
alias srcbrc="source ~/.bashrc && echo \~/.bashrc sourced"
alias upbrc="cp ~/.bashrc $git_repo && echo \~/.bashrc updated in git repo"
alias vbrc="vim ~/.bashrc"

# Deal with ~/.gitconfig in single commands
alias upgc="cp ~/.gitconfig $git_repo && echo \~/.gitconfig updated in git repo"
alias vgc="vim ~/.gitconfig"

# Deal with neofetch config in single commands
alias upnf="cp ~/.config/neofetch/config.conf $git_repo/neofetch_config && echo \~/.config/neofetch/config.conf updated in git repo"
alias vnf="vim ~/.config/neofetch/config.conf"

# Source and update ~/.vimrc, ~/.bashrc, ~/,bash_aliases, and ~/.gitconfig
alias srcupall="upvrc;srcbal;upbal;srcbrc;upbrc;upgc;upnf;echo;echo Everything sourced and updated"
alias srcall="srcbal;srcbrc;echo;echo Everything sourced"
alias upall="upvrc;upbal;upbrc;upgc;upnf;echo;echo Everything updated"

alias fullsrcup="srcupall;echo;srcupall" # Do it twice just to be sure

# Update and upgrade apt and apt-get libraries
alias suaptup="sudo apt -y update && sudo apt -y upgrade;echo;sudo apt-get -y update && sudo apt-get -y upgrade;echo;sudo apt -y autoremove;echo;sudo apt-get -y autoremove;echo;echo apt and apt-get updated and upgraded"

# Echo my public IP address from ipinfo.io/ip
alias myip="curl ipinfo.io/ip;echo"

# Make a directory and cd into it
mkcd () {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Start ssh-agent
alias sshag="eval \"\$(ssh-agent -s)\""
# List ssh keys in agent
alias sshl="ssh-add -l"
# Remove all ssh keys from agent
alias sshd="ssh-add -D"

# Add the github_main private key to ssh-agent
alias addmainghssh="ssh-add ~/.ssh/github_main"
# Same but with john_smith_github
alias addjsghssh="ssh-add ~/.ssh/john_smith_github"

# Switch GitHub accounts
alias gitswitch="bash ~/repos/misc-personal/gitswitch.sh"

alias gp="git push"
alias gst="git status"
alias ga="git add -A"
alias gf="git fetch"
alias gpl="git pull"
alias gfp="git fetch;git pull"
alias gl="git log"

alias gstall="python /home/dyson/repos/gst_all.py"

# Search long-form history
alias grephist="cat ~/.bash_history | grep"

# Copy Unicode code point (passed as $1)
CopyUnicodeCodePoint() {
    string="\\u$1"
    python -c "print('$string')" | xclip -selection c
}
alias cpunicp=CopyUnicodeCodePoint

# Create executable file and open it with vim
CreateAndVimExecutable() {
    touch $1
    chmod +x $1
    vim $1
}
alias vex=CreateAndVimExecutable

# Pipe to clip for easy copying
alias clip="xclip -selection c"

# Set APL xkb layout with AltGr as modifier key
alias aplkb="setxkbmap gb,apl -option grp:switch && echo 'You are now using an APL keyboard accessed with AltGr'"

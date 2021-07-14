# Single letter aliases
alias c="clear"
alias g="git"
alias n="nohup"
alias p="python"
alias t="touch"
alias v="vim"
alias x="exit"

# Two letter simple aliases
alias la="ls -a"
alias ll="ls -la"
alias lh="ls -lah"

alias ipy="python -m IPython"
alias pmhttp="python -m http.server"

# List all processes in a user-oriented format with ASCII art hierarchy by default
alias ps="ps axuf"

# An easily grepable ps
psg() {
	if [ "$1" != "" ]; then
		# This just prints the first line of output - the headers of the table
		\ps axuf | head -n 1
		# The "grep -v grep" in the middle filters out the grep process
		# Then the grep at the end just finds $1, in my prefered perl syntax
		\ps axuf | grep -v grep | grep -P "$1"
	else
		echo "Please supply something to grep for."
	fi
}

# Variable that holds the directory of the git repo holding this file and its associates
git_repo="$HOME/repos/Linux-Setup/Files"

# Deal with ~/.vimrc in single commands
alias upvrc="cp ~/.vimrc '$git_repo' && echo \~/.vimrc updated in git repo"
alias vvrc="vim ~/.vimrc"

# Deal with ~/.ideavimrc in single commands
alias upivrc="cp ~/.ideavimrc '$git_repo' && echo \~/.ideavimrc updated in git repo"
alias vivrc="vim ~/.ideavimrc"

# Deal with ~/.bash_aliases in single commands
alias srcbal="source ~/.bash_aliases && echo \~/.bash_aliases sourced"
alias upbal="cp ~/.bash_aliases '$git_repo' && echo \~/.bash_aliases updated in git repo"
alias vbal="vim ~/.bash_aliases"

# Deal with ~/.bashrc in single commands
alias srcbrc="source ~/.bashrc && echo \~/.bashrc sourced"
alias upbrc="cp ~/.bashrc '$git_repo' && echo \~/.bashrc updated in git repo"
alias vbrc="vim ~/.bashrc"

# Deal with ~/.gitconfig in single commands
alias upgc="cp ~/.gitconfig '$git_repo' && echo \~/.gitconfig updated in git repo"
alias vgc="vim ~/.gitconfig"

# Deal with neofetch config in single commands
alias upnf="cp ~/.config/neofetch/config.conf '$git_repo'/neofetch_config && echo \~/.config/neofetch/config.conf updated in git repo"
alias vnf="vim ~/.config/neofetch/config.conf"

# Deal with terminator config in single commands
alias uptmf="cp ~/.config/terminator/config '$git_repo'/terminator_config && echo \~/.config/terminator/config updated in git repo"
alias vtmf="vim ~/.config/terminator/config"

alias upipyc="cp ~/.ipython/profile_default/ipython_config.py '$git_repo' && echo \~/.ipython/profile_default/ipython_config.py updated in git repo"
alias vipyc="vim ~/.ipython/profile_default/ipython_config.py"

alias uppylrc="cp ~/.pylintrc '$git_repo' && echo \~/.pylintrc updated in git repo"
alias vpylrc="vim ~/.pylintrc"

# Source and update everything
alias srcall="srcbal;srcbrc;echo;echo Everything sourced"
alias upall="upvrc;upivrc;upbal;upbrc;upgc;upnf;uptmf;upipyc;uppylrc;echo;echo Everything updated"
alias srcupall="srcall;upall;echo;echo Everything sourced and updated"

alias fullsrcup="srcupall;echo;srcupall" # Do it twice just to be sure

# Update and upgrade apt and apt-get libraries
alias suaptup="sudo apt -y update && sudo apt -y upgrade;echo;sudo apt -y autoremove;echo;echo 'apt and apt-get updated and upgraded'"

# Echo my public IP address from ipinfo.io/ip
alias myip="curl ipinfo.io/ip;echo"

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
alias gitswitch="bash ~/repos/misc-personal/bash/gitswitch.sh"

alias gp="git push"
alias gpx="git push && exit"
alias gst="git status"
alias ga="git add -A"
alias gf="git fetch"
alias gpl="git pull"
alias gfpl="git fetch && git pull"
alias gl="git log"

alias gstall="python ~/repos/git_all.py status"
alias gfall="python ~/repos/git_all.py fetch"
alias gplall="python ~/repos/git_all.py pull"
alias gfplall="python ~/repos/git_all.py fetch && python ~/repos/git_all.py pull"
alias gpall="python ~/repos/git_all.py push"

# This alias is for my EPQ Activity Log
alias gcmaddacca="git commit -m 'Add Activity Log entry'"

# Search long-form history
alias grephist="cat ~/.bash_history | grep"

# Copy Unicode code point
cpunicp() {
	string="\\u$1"
	python -c "print('$string', end='')" | xclip -selection c
}

# Create executable file and open it with vim
vex() {
	touch "$1"
	chmod +x "$1"
	vim "$1"
}

# Pipe to clip for easy copying
alias clip="xclip -selection c"

# Easily copy a file
cclip() {
	cat "$1" | clip
}

# Decode base 64
b64d() {
	echo "$1" | base64 -d
}

# Make a directory without complaining that it already exists
mkd() {
	if [ ! -d "$1" ]; then
		mkdir -p -- "$1"
	fi
}

# Make a directory and cd into it
mkcd () {
	mkd "$1"
	cd -- "$1"
}

# Make a directory and push it onto to the stack
mkpushd() {
	mkd "$1"
	pushd -- "$1"
}

_custom_cd_or_pushd() {
	# We use eval to allow for code reuse for the cd and pushd versions
	# THIS FUNCTION SHOULD NEVER BE CALLED DIRECTLY BY THE USER

	# If it's a directory, just cd there
	if [ -d "$2" ]; then
		eval $1 -- "$2"

	# If it's a file, cd into the parent directory
	elif [ -f "$2" ]; then
		eval $1 -- '$(dirname "$2")'
	fi
}

custom_cd() {
	_custom_cd_or_pushd cd "$1"
}

custom_pushd() {
	_custom_cd_or_pushd pushd "$1"
}

# Move a file to a directory and cd into it
mvcd() {
	mv -- "$1" "$2"
	custom_cd "$2"
}

# Move a file to a directory and push it onto to the stack
mvpushd() {
	mv -- "$1" "$2"
	custom_pushd "$2"
}

# Copy a file to a directory and cd into it
cpcd() {
	cp -- "$1" "$2"
	custom_cd "$2"
}

# Make a directory and push it onto to the stack
cppushd() {
	cp -- "$1" "$2"
	custom_pushd "$2"
}

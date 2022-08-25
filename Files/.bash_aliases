# Use neovim if it exists
which nvim &> /dev/null
if [ $? -eq 0 ]; then
	alias vim="nvim"
	export EDITOR=$(which nvim)
else
	export EDITOR=$(which vim)
fi

# Single letter aliases
alias c="cat"
alias g="git"
alias j="julia"
alias p="python"
alias t="touch"
alias v="vim"
alias x="exit"

# Two letter simple aliases
alias cl="clear"
alias la="ls -a"
alias ll="ls -la"
alias lh="ls -lah"

alias rm="rm -v"  # If I ever accidentally delete the wrong thing, at least I know what's gone

alias ipy="python -m IPython"
alias jnb="jupyter notebook"
alias pnb="julia -e 'import Pluto; Pluto.run()'"
alias pmhttp="python -m http.server"
alias pip="python -m pip"
alias pup="python -m pip install --upgrade pip"

mkvenv() {
	if [ -d ./venv ] && [ "$1" != "-f" ]; then
		echo 'venv already exists. Use -f to force a new one'
		return 1
	elif [ -d ./venv ] && [ "$1" == "-f" ]; then
		rm -rf ./venv
	fi

	python -m venv venv
	. ./venv/bin/activate
	ln -f -s ./venv/bin/activate ...
	python -m pip install --upgrade pip
	python -m pip install wheel
}

rmvenv() {
	if [ ! -d ./venv ]; then
		echo 'venv does not exist'
		return 1
	fi

	deactivate
	[ -f ... ] && rm ...
	rm -rf ./venv
}

initvenv() {
	[ ! -d ./venv ] && mkvenv

	pip install numpy sympy bitstring IPython

	if [ -f ./requirements.txt ]; then
		pip install -r requirements.txt
	else
		touch requirements.txt
	fi
}

# List all processes in a user-oriented format with ASCII art hierarchy by default
alias ps="ps axuf"

# An easily grepable ps
psg() {
	if [ "$1" != "" ]; then
		# This just prints the first line of output - the headers of the table
		\ps axuf | head -n 1
		# This runs ps, filters out this specific grep command, and then greps for whatever I pass as args
		eval "\ps axuf | grep -v \"$(alias grep | \grep -Po "(?<=')[^']+(?=')") -P $@\" | grep -P $@"
	else
		echo "Please supply something to grep for."
	fi
}

# A custom nohup command to run a command silently in the background
no() {
	eval "nohup $* > /dev/null &"
}

nox() {
	eval "no $*"
	exit
}

alias vvrc="vim ~/.vimrc"
alias vinitv="vim ~/.config/nvim/init.vim"
alias vpl="vim ~/.config/nvim/lua/plugins.lua"
alias vcocset="vim ~/.config/nvim/coc-settings.json"
alias vivrc="vim ~/.ideavimrc"

alias srcbal="source ~/.bash_aliases && echo \~/.bash_aliases sourced"
alias vbal="vim ~/.bash_aliases"

alias srcbrc="source ~/.bashrc && echo \~/.bashrc sourced"
alias vbrc="vim ~/.bashrc"

alias vgc="vim ~/.gitconfig"
alias vnf="vim ~/.config/neofetch/config.conf"
alias vtmf="vim ~/.config/terminator/config"
alias vipyc="vim ~/.ipython/profile_default/ipython_config.py"
alias vpylrc="vim ~/.pylintrc"
alias vxcomp="vim ~/.XCompose"
alias vsjl="vim ~/.julia/config/startup.jl"
alias vis="vim ~/.sage/init.sage"

alias vbatc="vim ~/.config/bat/config"
alias vfdi="vim ~/.config/fd/ignore"
alias vrgc="vim ~/.config/ripgrep/config"

# Source and update everything
alias srcall="srcbal;srcbrc;echo;echo Everything sourced"
alias srcupall="srcall;upall;echo;echo Everything sourced and updated"

# Update and upgrade apt libraries
alias suaptup="sudo apt -y update && sudo apt -y upgrade;echo;sudo apt -y autoremove --purge;echo;echo 'apt updated and upgraded'"

# This is a function because if it's an alias, the curl command gets
# evaluated when the file is sourced rather than when the alias is run
# We need to run it through echo to get a newline at the end
myip() {
	echo $(curl --silent ipinfo.io/ip)
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
alias gitswitch="bash ~/repos/misc-personal/bash/gitswitch.sh"

alias gp="git push"
alias gpfwl="git push --force-with-lease"
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

# Search long-form history
alias grephist="cat ~/.bash_history | grep --"

# Copy Unicode code point
cpunicp() {
	string="\\u$1"
	python -c "print('$string', end='')" | xclip -selection c
}

# Create executable file and open it with vim
vex() {
	vim "$1"
	if [ -f "$1" ]; then
		chmod +x "$1"
	fi
}

# Pipe to clip for easy copying
alias clip="xclip -selection c"

# Easily copy a file
cclip() {
	cat "$1" | clip
}

clipo() {
	echo "$(clip -o)"
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

_source_dotdotdot() {
	# If ... is a symlink, source it
	if [ -L "..." ]; then
		echo "Sourcing $(readlink ...)"
		source ...
	else
		echo "No '...' symlink to source"
	fi
}

# Bash doesn't like a function with this name, so we just alias it
alias ..="_source_dotdotdot"

_small_prompt_function() {
	if [ "$(pwd)" = "/" ]; then
		directory="/"
	else
		directory=$(pwd | grep -Po '(/[^/]+)?(/[^/]+)?/[^/]+$')
		# If this is a real directory, then we can just leave it
		# because / is the root, but if not, we need to add a .. to
		# show that this directory isn't absolute
		if [ ! -d "$directory" ]; then
			directory="..$directory"
		fi
	fi

	PS1="\[\033[01;34m\]$directory\[\033[00m\] \[\033[01;31m\]\$ \[\033[00m\]"
}

small_prompt() {
	# Make the prompt small but keep directory
	export PROMPT_COMMAND=_small_prompt_function
}

tiny_prompt() {
	# Make the prompt small, optimal for small terminal panes
	export PROMPT_COMMAND=
	export PS1="\[\033[01;31m\]\$ \[\033[00m\]"
}

alias youtube-dl-s="youtube-dl --config-location ~/.config/youtube-dl/soundtracks.conf"
alias youtube-dl-a="youtube-dl --config-location ~/.config/youtube-dl/albums.conf"

# Print the binary encoding (UTF-8 by default) of the input
utf8() {
	case "$1" in
		'-b')
			echo $(echo -n "$2" | xxd -b | grep -iPo "(?<=[0-9a-f]{8}: )([01]{8} )+" | tr -d "\n" | xargs | tr " " ":")
			;;
		'-h')
			echo $(echo -n "$2" | xxd -g 1 | grep -iPo "(?<=[0-9a-f]{8}: )([0-9a-f]{2} )+" | tr -d "\n" | xargs | tr " " ":")
			;;
		*)
			echo "Usage: utf8 -b|-h string"
			;;
	esac
}

alias rclone="rclone --progress --bwlimit=\"09:00,256 23:00,off\""

alias resetwifi="nmcli networking off && nmcli networking on"

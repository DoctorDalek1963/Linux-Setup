# === Defaults

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=-1

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the PS1)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

# Set completion to be case INsensitive
bind -s 'set completion-ignore-case on'

# === PS1

# We want the PS1 to be extended by default
EXTENDED_PS1=1

# This whole function just builds the PS1
build_prompt() {
	local exit_code="$?" # We need this first to catch it

	history -a

	local force_color_prompt=yes
	local color_prompt=

	PS1=""

	if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
		else
		color_prompt=
		fi
	fi

	if [ "$color_prompt" = yes ]; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
	else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
	fi

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
	esac

	if [ $EXTENDED_PS1 -ne 0 ]; then
		if [ ! -f ~/.git-prompt.sh ]; then
			if [ -f ~/git-prompt.sh ]; then
				mv ~/git-prompt.sh ~/.git-prompt.sh
			else
				echo "GETTING ~/.git-prompt.sh"
				wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
				mv git-prompt.sh ~/.git-prompt.sh
			fi
		fi

		# Add git information and $ to prompt
		GIT_PS1_SHOWDIRTYSTATE=true
		GIT_PS1_SHOWSTASHSTATE=true
		GIT_PS1_SHOWUNTRACKEDFILES=true
		GIT_PS1_SHOWUPSTREAM="auto"
		GIT_PS1_HIDE_IF_PWD_IGNORED=true

		source ~/.git-prompt.sh

		if [ "$color_prompt" = yes ]; then
			PS1="$PS1\[\033[01;31m\]$(__git_ps1 " [%s]")\[\033[00m\]"
		else
			PS1="$PS1$(__git_ps1 " [%s]")"
		fi
	fi

	if [ -n "$VIRTUAL_ENV" ] && [ $EXTENDED_PS1 -ne 0 ]; then
		# If there is a venv, we only want the penultimate dir in the path, so we grep it
		venv=$(echo $VIRTUAL_ENV | grep -Po "[^/]*(?=/[^/]*$)")
		# We then disable the normal venv prompt addition
		VIRTUAL_ENV_DISABLE_PROMPT=1

		# We then add the venv to the start of the PS1, in a nice cyan colour if possible
		if [ "$color_prompt" = yes ]; then
			PS1="\[\033[01;36m\]($venv)\[\033[00m\] $PS1"
		else
			PS1="($venv) $PS1"
		fi
	fi

	if [ $exit_code -ne 0 ] && [ $EXTENDED_PS1 -ne 0 ]; then
		if [ "$color_prompt" = yes ]; then
			PS1="\[\033[01;31m\]$exit_code\[\033[00m\] $PS1"
		else
			PS1="$exit_code $PS1"
		fi
	fi

	PS1="$PS1\n\[\033[01;32m\]\$\[\033[00m\] "
}

PROMPT_COMMAND=build_prompt

# === Aliases and colours

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

	alias diff='diff --color=always'
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some more ls aliases
alias ll='ls -la'
alias la='ls -a'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Load the separate ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# === Custom scripts

# Source personal completion scripts
if [ -d $HOME/.local/misc/bash-completion ]; then
	for f in $HOME/.local/misc/bash-completion/*; do
		. "$f"
	done
fi

# Add dirs in /opt to PATH
[ -f /opt/add_to_path ] && . /opt/add_to_path

# === PATH config

# Configure PATH for sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Configure paths for TeXLive
[ -d "$HOME/.texlive/2021/texmf-dist/doc/man" ] && MANPATH="$HOME/.texlive/2021/texmf-dist/doc/man:$MANPATH"
[ -d "$HOME/.texlive/2021/texmf-dist/doc/info" ] && INFOPATH="$HOME/.texlive/2021/texmf-dist/doc/info:$INFOPATH"
[ -d "$HOME/.texlive/2021/bin/x86_64-linux" ] && PATH="$HOME/.texlive/2021/bin/x86_64-linux:$PATH"

# === Environment variables

export ATHAME_ENABLED=0
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"

export JILL_INSTALL_DIR="$HOME/.local/misc/julia-versions"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

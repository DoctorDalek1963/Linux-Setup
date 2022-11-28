# Single letter aliases
alias b = bat
alias c = cat
alias g = git
alias j = just
alias l = ls -a
alias p = python
alias t = touch
alias v = nvim

# Two letter simple aliases
alias ca = cargo
alias cl = clear
alias jl = julia
alias ll = ls -la

alias rm = rm -v  # If I ever accidentally delete the wrong thing, at least I know what's gone

alias ipy = python -m IPython
alias jnb = jupyter notebook
alias pnb = julia -e 'import Pluto; Pluto.run()'
alias pmhttp = python -m http.server
alias pip = python -m pip
alias pup = python -m pip install --upgrade pip
alias rs = evcxr

alias clippy = (cat $HOME/.cargo/clippy.conf | xargs cargo clippy --)

#mkvenv() {
	#if [ -d ./venv ] && [ "$1" ! =  "-f" ]; then
		#echo 'venv already exists. Use -f to force a new one'
		#return 1
	#elif [ -d ./venv ] && [ "$1"  = = -f ]; then
		#rm -rf ./venv
	#fi

	#python -m venv venv
	#. ./venv/bin/activate
	#ln -f -s ./venv/bin/activate ...
	#python -m pip install --upgrade pip
	#python -m pip install wheel
#}

#rmvenv() {
	#if [ ! -d ./venv ]; then
		#echo 'venv does not exist'
		#return 1
	#fi

	#deactivate
	#[ -f ... ] && rm ...
	#rm -rf ./venv
#}

#initvenv() {
	#[ ! -d ./venv ] && mkvenv

	#pip install numpy sympy bitstring IPython

	#if [ -f ./requirements.txt ]; then
		#pip install -r requirements.txt
	#else
		#touch requirements.txt
	#fi
#}

# list all processes in a user-oriented format with ASCII art hierarchy by default
alias ps = ^ps axuf

# an easily grepable ps
#psg() {
	#if [ "$1" ! =  "" ]; then
		## This just prints the first line of output - the headers of the table
		#\ps axuf | head -n 1
		## This runs ps, filters out this specific grep command, and then greps for whatever I pass as args
		#eval "\ps axuf | grep -v \"$(alias grep | \grep -Po "(?< = ')[^']+(?=')") -P $@\" | grep -P $@"
	#else
		#echo "Please supply something to grep for."
	#fi
#}

alias vvrc = nvim ~/.vimrc
alias vinitv = nvim ~/.config/nvim/init.vim
alias vpl = nvim ~/.config/nvim/lua/plugins.lua
alias vcocset = nvim ~/.config/nvim/coc-settings.json
alias vivrc = nvim ~/.ideavimrc

alias vgc = nvim ~/.gitconfig
alias vnf = nvim ~/.config/neofetch/config.conf
alias vtmf = nvim ~/.config/terminator/config
alias vipyc = nvim ~/.ipython/profile_default/ipython_config.py
alias vpylrc = nvim ~/.pylintrc
alias vsjl = nvim ~/.julia/config/startup.jl
alias vis = nvim ~/.sage/init.sage

alias vcc = nvim ~/.cargo/config.toml
alias vclc = nvim ~/.cargo/clippy.conf
alias vbatc = nvim ~/.config/bat/config
alias vfdi = nvim ~/.config/fd/ignore
alias vrgc = nvim ~/.config/ripgrep/config

alias srcnu = source ~/.config/nushell/config.nu

# update and upgrade apt libraries
alias suaptup = (sudo apt -y update; echo; sudo apt -y upgrade; echo; sudo apt -y autoremove --purge; echo; echo 'apt updated and upgraded')

# print current IP address
def myip [] {
	curl --silent ipinfo.io/ip
}

alias gp = git push
alias gpfwl = git push --force-with-lease
alias gpx = git push && exit
alias gst = git status
alias ga = git add -A
alias gf = git fetch
alias gpl = git pull
alias gfpl = git fetch && git pull
alias gl = git log

alias gstall = python ~/repos/git_all.py status
alias gfall = python ~/repos/git_all.py fetch
alias gplall = python ~/repos/git_all.py pull
alias gfplall = (python ~/repos/git_all.py fetch; python ~/repos/git_all.py pull)
alias gpall = python ~/repos/git_all.py push

# search long-form history
def grephist [pattern: string] {
	open $nu.history-path | find $pattern
}

# create executable file and open it with nvim
def vex [fname: string] {
	nvim $fname
	if (echo $fname | path exists) {
		chmod +x $fname
	}
}

# pipe to clip for easy copying
alias clip = xclip -selection c
alias clipo = clip -o

# easily copy a file
def cclip [fname: string] {
	cat $fname | clip
}

alias mkd = mkdir

# make a directory and cd into it
def mkcd [dir: string] {
	mkdir $dir
	cd $dir
}

#_source_dotdotdot() {
	#local curdir = $(pwd)

	## If ... is a symlink, source it
	#if [ -L "..." ]; then
		## This sed expression replaces $HOME with ~
		#echo "Sourcing $(readlink -f ... | sed "s/$(echo "$HOME" | sed 's/\//\\\//g')/~/" | sed "s/venv\/bin\/activate/.../")"
		#source ...
	#else
		## Recurse up the filesystem until we find a ... symlink or hit /
		#if [ "$(pwd)"  =  "/" ]; then
			#echo "No '...' symlink to source"
		#else
			#cd ..
			#_source_dotdotdot
		#fi
	#fi

	#cd "$curdir"
#}

# bash doesn't like a function with this name, so we just alias it
#alias .. = _source_dotdotdot

alias youtube-dl-s = youtube-dl --config-location ~/.config/youtube-dl/soundtracks.conf
alias youtube-dl-a = youtube-dl --config-location ~/.config/youtube-dl/albums.conf

alias rclone = rclone --progress --bwlimit="09:00,256 23:00,off"

alias resetwifi = nmcli networking off && nmcli networking on

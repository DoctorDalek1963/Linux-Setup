def create_right_prompt [] {
	[
		(if (is-admin) { ansi red_bold } else { ansi green_bold })
		$env.USER
		"@"
		(hostname)
		(ansi reset)
	] | str join
}

def create_left_prompt [] {
	if not ('~/.git-prompt.sh' | path exists) {
		print -e "Getting ~/.git-prompt.sh"
		wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -qO ~/.git-prompt.sh
	}

	[
		(if $env.LAST_EXIT_CODE != 0 { [(ansi red_bold) $env.LAST_EXIT_CODE " " (ansi reset)] | str join })

		(ansi blue_bold)
		($env.PWD | str replace $env.HOME "~")
		(ansi red_bold)

		# This is some magic using bash to call a function in a shell script to generate the git part of the prompt
		(bash -c 'source ~/.git-prompt.sh; export GIT_PS1_SHOWDIRTYSTATE=true GIT_PS1_SHOWSTASHSTATE=true GIT_PS1_SHOWUNTRACKEDFILES=true GIT_PS1_SHOWUPSTREAM="auto" GIT_PS1_HIDE_IF_PWD_IGNORED=true; echo "$(__git_ps1 " [%s]")"')

		(ansi reset)

		# U+200B is a no-break space, which allows the marker to be on a new line. The newline comes from the `echo` in the bash magic
		("\u200B")
	] | str join
}

let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

#let-env SHELL = /home/dyson/.cargo/bin/nu

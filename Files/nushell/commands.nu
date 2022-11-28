module commands {
	def get-path [] {
		$nu.config-path | path parse | get parent
	}

	def conf-edit [fname: string] {
		nvim ([ (get-path) $fname ] | str join '/')
	}

	# Edit the root config.nu file
	export def "conf config" [] {
		conf-edit "config.nu"
	}

	# Edit the vars.nu file
	export def "conf vars" [] {
		conf-edit "vars.nu"
	}

	# Edit the env.nu file
	export def "conf env" [] {
		conf-edit "env.nu"
	}

	# Edit the completions.nu file
	export def "conf completions" [] {
		conf-edit "completions.nu"
	}

	# Edit the aliases.nu file
	export def "conf aliases" [] {
		conf-edit "aliases.nu"
	}

	# Edit the commands.nu file
	export def "conf commands" [] {
		conf-edit "commands.nu"
	}
}

use commands *

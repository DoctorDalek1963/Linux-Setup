def complete-setup [] {
	./setup -h
	| lines
	| skip 5
	| drop 6
	| where ($it | str length) > 0
	| each {
		let words = ($in | split row ' ');
		{
			value: ($words | get 0),
			description: ($words | skip 1 | str join ' ')
		}
	}
	| append { value: "--help", description: "Show help." }
}

export extern "./setup" [
	...options: string@complete-setup # The options to the script
	--help(-h)                        # Show help.
]

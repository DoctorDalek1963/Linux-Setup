# TODO: sdkman
let-env PATH = ($env.PATH | prepend ([ $env.HOME '.texlive/2021/bin/x86_64-linux' ] | str join '/'))
let-env PATH = ($env.PATH | append ([ $env.HOME '.cabal/bin' ] | str join '/'))
let-env PATH = ($env.PATH | append ([ $env.HOME '.ghcup/bin' ] | str join '/'))

let-env EDITOR = (which nvim | get 0.path)

source /home/dyson/.config/nushell/vars.nu
source /home/dyson/.config/nushell/completions.nu
source /home/dyson/.config/nushell/aliases.nu
source /home/dyson/.config/nushell/commands.nu

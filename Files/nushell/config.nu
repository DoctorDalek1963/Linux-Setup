# TODO: sdkman
let-env PATH = ($env.PATH | prepend ([ $env.HOME '.texlive/2021/bin/x86_64-linux' ] | str join '/'))
let-env PATH = ($env.PATH | append ([ $env.HOME '.cabal/bin' ] | str join '/'))
let-env PATH = ($env.PATH | append ([ $env.HOME '.ghcup/bin' ] | str join '/'))

let-env EDITOR = (which nvim | get 0.path)

source "vars.nu"
source "env.nu"
source "completions.nu"
source "aliases.nu"
source "commands.nu"

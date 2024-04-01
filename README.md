# Linux-Setup

![License](https://img.shields.io/github/license/DoctorDalek1963/Linux-Setup)
![Last Commit](https://img.shields.io/github/last-commit/DoctorDalek1963/Linux-Setup)

![Repo Size](https://img.shields.io/github/repo-size/DoctorDalek1963/Linux-Setup)
![Code Size](https://img.shields.io/github/languages/code-size/DoctorDalek1963/Linux-Setup)

## NOTICE

I have switched to [NixOS](https://nixos.org/) and this repo has been superseded by [my NixOS config](https://github.com/DoctorDalek1963/nixos-config). All my dotfiles and system config now live there, except for my [Neovim](https://neovim.io/) config, which lives [here](https://github.com/DoctorDalek1963/nixvim-config).

---

This is a small, simple repo to hold dotfiles for my Linux machines.

For ease of use, it contains a setup script called `setup`, which can symlink the dotfiles and
install other software, such as the `nvim` package manager `packer.nvim`, and use this to install
all the plugins defined in `plugins.lua`.

Since this project now uses symlinks, I recommend keeping this directory cloned and up-to-date.

In bash, you can use `source .setup-completion.bash` to get tab autocompletion. See `./setup
--help` for all the available commands.

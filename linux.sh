#!/usr/bin/env bash

set -e

printf "\n -- LINUX SETUP \n"

if ! which nix > /dev/null; then
    printf "\n -- INSTALLING NIX \n"
    sh <(curl -L https://nixos.org/nix/install) --daemon
    reset
fi

nix-env -iA \
    nixpkgs.zsh nixpkgs.oh-my-zsh nixpkgs.fzf nixpkgs.lsd nixpkgs.navi nixpkgs.bat nixpkgs.starship \
    nixpkgs.jetbrains-mono \
    nixpkgs.gum nixpkgs.jq nixpkgs.fd nixpkgs.htop nixpkgs.socat \
    nixpkgs.gcc nixpkgs.clang nixpkgs.cmake nixpkgs.fnm

NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.vscode

if ! [[ "$SHELL" == *"zsh" ]]; then
    printf "\n -- SETTING ZSH AS LOGIN SHELL \n"
    chsh -s "$(which zsh)"
    printf "\n -- COMPLETE: YOU WILL NEED TO LOGIN AGAIN \n"
fi

# dconf dump /org/gnome/terminal/ > gnome-terminal.preferences
dconf load /org/gnome/terminal/ < gnome-terminal.preferences

printf "\n -- COMPLETE \n"

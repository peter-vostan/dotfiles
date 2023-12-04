#!/usr/bin/env bash

set -e

printf "\n -- CREATING SYMLINKS \n"

function symlink() {
    echo "${2} -> ${1}"
    ln -snfF "${1}" "${2}"
}

symlink "$PWD"/gitignore_global ~/.gitignore_global
symlink "$PWD"/zprofile ~/.zprofile
symlink "$PWD"/zshrc ~/.zshrc
symlink "$PWD"/zshenv ~/.zshenv

printf "\n -- CONFIGURING GIT \n"

git config --global core.excludesfile ~/.gitignore_global
git config --global push.autoSetupRemote true
git config --global pull.rebase false
git config --global alias.prune-branches "!bash -c \"shopt -s expand_aliases; . ${DOTFILES}/aliases && . ${DOTFILES}/functions && git-prune-branches\""

if ! git config --global user.name > /dev/null; then
    read -r -p "git user name: " GIT_USER_NAME
    git config --global user.name "${GIT_USER_NAME}"
fi

if ! git config --global user.email > /dev/null; then
    read -r -p "git user email: " GIT_USER_EMAIL
    git config --global user.email "${GIT_USER_EMAIL}"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    ./macos.sh
elif [[ "$OSTYPE" == "linux"* ]]; then
    ./linux.sh
fi

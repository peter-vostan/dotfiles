#!/usr/bin/env bash

set -e

function symlink() {
    echo "${2} -> ${1}"
    ln -sf "${1}" "${2}"
}

function enableSudoTouchId() {
    if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null; then
        echo 'Enabling sudo touch id'
        sudo sed -i '' '1a\
auth       sufficient     pam_tid.so
        ' /etc/pam.d/sudo
    fi
}

echo '
----- CHECKING DEPENDENCIES
'

if ! which brew > /dev/null; then
    echo 'Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo 'brew already installed'
fi

if ! which nix > /dev/null; then
    echo 'Installing nix'
    sh <(curl -L https://nixos.org/nix/install)
else
    echo 'nix already installed'
fi

if ! which rustup > /dev/null; then
    echo 'Installing rust'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo 'rust already installed'
fi

echo '
----- CREATING SYMLINKS
'
symlink "$PWD"/brew/Brewfile ~/.Brewfile
symlink "$PWD"/conda/condarc ~/.condarc
symlink "$PWD"/terminal/aliases ~/.aliases
symlink "$PWD"/terminal/functions ~/.functions
symlink "$PWD"/terminal/zshrc ~/.zshrc
mkdir -p ~/.config;     symlink "$PWD"/terminal/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/nix; symlink "$PWD"/nix/nix.conf ~/.config/nix/nix.conf

echo '
----- RUNNING: $ brew bundle --global
'
brew bundle --global

echo '
----- RUNNING: $ brew bundle cleanup --global
'
brew bundle cleanup --global

echo '
----- RUNNING: $ mas outdated
'
mas outdated

echo '
----- GENERAL CONFIG
'

if ! git config --global alias.hack > /dev/null; then
    echo 'Adding git-town aliases'
    git-town alias true
fi

# OS specific config
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Enable sudo touch id auth if it isn't already
    enableSudoTouchId

    # https://macos-defaults.com/
    # https://github.com/mathiasbynens/dotfiles/blob/main/.macos

    defaults write com.apple.dock "tilesize" -int 36
    defaults write com.apple.dock "orientation" left
    defaults write com.apple.dock "show-recents" -bool false
    defaults write com.apple.dock "autohide" -bool true
    defaults write com.apple.dock "autohide-delay" -float "0"
    defaults write com.apple.dock "autohide-time-modifier" -float "0"
    defaults write com.apple.dock "mineffect" -string "scale"

    defaults write com.apple.finder "ShowPathbar" -bool true
    defaults write com.apple.finder "ShowStatusbar" -bool true
    # defaults write com.apple.finder "AppleShowAllFiles" -bool true

    defaults write com.apple.screencapture "type" -string "jpg"

    # defaults write com.apple.Safari "ShowFavoritesBar" -bool false
    # defaults write com.apple.Safari "HomePage" -string "about:blank"
    # defaults write com.apple.Safari UniversalSearchEnabled -bool false

    defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
    defaults write NSGlobalDomain "KeyRepeat" -int 2
    defaults write NSGlobalDomain "InitialKeyRepeat" -int 25
    defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool false

    # Disable siri
    # Disable screentime
    # Disable spotlight indexing??
    # Finder: remove tags / recents, add home / library

    chflags nohidden ~/Library

    killall Finder
    killall Dock
fi

echo 'Apps that require login: Warp, Vscode (settings sync)'

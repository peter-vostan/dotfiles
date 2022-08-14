#!/usr/bin/env bash

set -e

function symlink() {
    echo "${2} -> ${1}"
    ln -snf "${1}" "${2}"
}

function enableSudoTouchId() {
    if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null; then
        echo 'Enabling sudo touch id'
        sudo sed -i '' '1a\
auth       sufficient     pam_tid.so
        ' /etc/pam.d/sudo
    fi
}

function installOhMyZshCustomPlugin() {
    if ! [ -d "${HOME}/.oh-my-zsh/custom/plugins/${1}" ]; then
        echo "Installing ${1}"
        git clone "${2}" "${HOME}/.oh-my-zsh/custom/plugins/${1}"
    else
        echo "${1} already installed"
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

if ! [ -d ~/.oh-my-zsh ]; then
    echo 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo 'oh-my-zsh already installed'
fi

installOhMyZshCustomPlugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
installOhMyZshCustomPlugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

echo '
----- CREATING SYMLINKS
'
symlink "$PWD"/Brewfile ~/.Brewfile
symlink "$PWD"/condarc ~/.condarc
symlink "$PWD"/gitignore_global ~/.gitignore_global
symlink "$PWD"/aliases ~/.aliases
symlink "$PWD"/functions ~/.functions
symlink "$PWD"/zshrc ~/.zshrc
symlink "$PWD"/zshenv ~/.zshenv

mkdir -p ~/.config;
    symlink "$PWD"/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/kitty;
    symlink "$PWD"/kitty.conf      ~/.config/kitty/kitty.conf;
    symlink "$PWD"/kitty-themes    ~/.config/kitty/themes;

mkdir -p ~/.config/nix;
    symlink "$PWD"/nix.conf ~/.config/nix/nix.conf

echo '
----- RUNNING: $ brew bundle --global
'
brew bundle --global

echo '
----- RUNNING: $ brew bundle cleanup --global
'
brew bundle cleanup --global

echo '
----- GENERAL CONFIG
'

git config --global core.excludesfile ~/.gitignore_global

if ! git config --global alias.hack > /dev/null; then
    echo 'Adding git-town aliases'
    git-town alias true
fi

# OS specific config
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! [ -f ~/.terminfo/78/xterm-kitty ]; then
        echo 'Installing kitty terminfo'
        tic -x -o ~/.terminfo /Applications/kitty.app/Contents/Resources/kitty/terminfo/kitty.terminfo
        echo ''
    fi

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

    # Finder: remove tags / recents, add home / library

    chflags nohidden ~/Library

    killall Finder
    killall Dock
fi

echo 'Apps to install via App Store'
echo ' - Bitwarden'
echo ' - Tailscale'
echo ' - AdGuard for Safari'
echo ''
echo 'Manual actions'
echo ' - Login to vscode settings sync'
echo ' - Login to fig'
echo ' - Add "Include ~/.fig/ssh" into "~/.ssh/config" to use fig over ssh'
echo ' - Disable spotlight command + space shortcut key'
echo ' - Setup Raycast command + space shortcut key'
echo ' - Setup Kitty option + space shortcut key (via Raycast)'
echo ''
echo 'Brew'
echo ' $ brew bundle cleanup --global --force'
echo ''
echo 'Git'
echo ' $ git config --global user.name ""'
echo ' $ git config --global user.email ""'

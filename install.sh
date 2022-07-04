#!/usr/bin/env bash

set -e

echo '
----- CONFIGURING OS
'
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Macos preferences
    defaults write com.apple.dock tilesize -int 36
    defaults write com.apple.dock orientation left
    defaults write com.apple.dock autohide -bool true
    defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool true
    defaults write NSGlobalDomain KeyRepeat -int 4
    defaults write NSGlobalDomain InitialKeyRepeat -int 25

    # Enable sudo touch id auth if it isn't already
    if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null; then
        echo 'Enabling sudo touch id'
        sudo sed -i '' '1a\
auth       sufficient     pam_tid.so
        ' /etc/pam.d/sudo
    fi
fi

echo '
----- CHECKING DEPENDENCIES
'

# Install oh-my-zsh if it isn't already
if ! [ -d ~/.oh-my-zsh ]; then
    echo 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install homebrew if it isn't already
if ! which brew > /dev/null; then
    echo 'Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install rust if it isn't already
if ! which rustup > /dev/null; then
    echo 'Installing rust'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo '
----- CREATING SYMLINKS
'
ln -sf "$PWD"/terminal/aliases ~/.aliases
ln -sf "$PWD"/terminal/functions ~/.functions
ln -sf "$PWD"/terminal/zshrc ~/.zshrc
ln -sf "$PWD"/brew/Brewfile ~/.Brewfile
mkdir -p ~/.config;         ln -sf "$PWD"/terminal/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/nix;     ln -sf "$PWD"/nix/nix.conf ~/.config/nix/nix.conf

echo '
----- RUNNING: $ brew bundle --global
'
brew bundle --global

echo '
----- RUNNING: $ brew bundle cleanup --global
'
brew bundle cleanup --global

echo '
----- POST INSTALL INSTRUCTIONS
'

echo 'Manual app setup required
    Fig     -> Open, grant permissions and setup with email
    Vscode  -> Open and turn on settings sync
'

# OS specific post install instructions
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Output instructions to configure terminal profile
    # TODO: surely this could be scripted ??
    echo 'terminal -> Preferences -> Settings -> Profiles -> Default
    Font    -> FiraCode Nerd Font -> Regular -> 11
    Cursor  -> Vertical Bar
    Cursor  -> Blink cursor
    '
fi

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

# Install oh-my-zsh if it isn't already
if ! [ -d ~/.oh-my-zsh ]; then
    echo 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo 'oh-my-zsh already installed'
fi

# Install homebrew if it isn't already
if ! which brew > /dev/null; then
    echo 'Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo 'brew already installed'
fi

# Install rust if it isn't already
if ! which rustup > /dev/null; then
    echo 'Installing rust'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo 'rust already installed'
fi

echo '
----- CREATING SYMLINKS
'
symlink "$PWD"/terminal/aliases ~/.aliases
symlink "$PWD"/terminal/aliases ~/.aliases
symlink "$PWD"/terminal/functions ~/.functions
symlink "$PWD"/terminal/zshrc ~/.zshrc
symlink "$PWD"/brew/Brewfile ~/.Brewfile
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
----- POST INSTALL INSTRUCTIONS
'

echo 'Manual app setup required
    Git-Town    -> git-town alias true
    Fig         -> Open, grant permissions and setup with email
    Vscode      -> Open and turn on settings sync
'

# OS specific config
if [[ "$OSTYPE" == "darwin"* ]]; then
    defaults write com.apple.dock tilesize -int 36
    defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool true
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 25

    FONT="FiraCode Nerd Font";
    FONT_SIZE=12;
    osascript -e "
        tell application \"Terminal\"
            set font name of (get startup settings) to \"${FONT}\"
            set font size of (get startup settings) to \"${FONT_SIZE}\"
        end tell"

    # Enable sudo touch id auth if it isn't already
    enableSudoTouchId

    # TODO: surely this could be scripted ??
    echo 'Configure terminal cursor
    terminal -> Preferences -> Settings -> Profiles -> Default
        Cursor  -> Vertical Bar
        Cursor  -> Blink cursor
    '
fi

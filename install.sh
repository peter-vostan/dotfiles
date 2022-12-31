#!/usr/bin/env bash

set -e

function symlink() {
    echo "${2} -> ${1}"
    ln -snf "${1}" "${2}"
}

function enableSudoTouchId() {
    if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null && gum confirm "Enable sudo touch id?"; then
        echo 'Enabling sudo touch id'
        sudo sed -i '' '1a\
auth       sufficient     pam_tid.so
        ' /etc/pam.d/sudo
    fi
}

function installOhMyZshCustomPlugin() {
    local directory="${HOME}/.oh-my-zsh/custom/plugins/${1}"
    if ! [ -d "${directory}" ]; then
        echo ''
        echo "---- Installing ${1}"
        echo ''
        git clone "${2}" "${directory}"
    else
        git -C "${directory}" fetch
        local local_commit; local_commit=$(git -C "${directory}" rev-parse @)
        local upstream_commit; upstream_commit=$(git -C "${directory}" rev-parse "@{u}")
        if ! [ "${local_commit}" = "${upstream_commit}" ] && gum confirm "Update ${1}?"; then
            git -C "${directory}" pull
        fi
    fi
}

echo ''
echo '-- CHECKING DEPENDENCIES'
echo ''

if ! which brew > /dev/null; then
    echo 'Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! brew list gum > /dev/null; then
    echo 'Installing gum via brew (required for install script script)'
    brew install gum
fi

if ! which nix > /dev/null && gum confirm "Install nix?"; then
    echo 'Installing nix'
    sh <(curl -L https://nixos.org/nix/install)
fi

if ! which rustup > /dev/null && gum confirm "Install rust?"; then
    echo 'Installing rust'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! [ -d ~/.oh-my-zsh ]; then
    echo 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

installOhMyZshCustomPlugin fzf-tab https://github.com/Aloxaf/fzf-tab.git
installOhMyZshCustomPlugin zsh-completions https://github.com/zsh-users/zsh-completions.git       # TODO: This doesn't support flakes...
installOhMyZshCustomPlugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
installOhMyZshCustomPlugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

echo ''
echo '-- CREATING SYMLINKS'
echo ''

symlink "$PWD"/aliases ~/.aliases
symlink "$PWD"/Brewfile ~/.Brewfile
symlink "$PWD"/condarc ~/.condarc
symlink "$PWD"/functions ~/.functions
symlink "$PWD"/gitignore_global ~/.gitignore_global
symlink "$PWD"/zprofile ~/.zprofile
symlink "$PWD"/zshrc ~/.zshrc
symlink "$PWD"/zshenv ~/.zshenv

mkdir -p ~/.config;
    symlink "$PWD"/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/kitty;
    symlink "$PWD"/kitty.conf      ~/.config/kitty/kitty.conf;
    symlink "$PWD"/kitty-themes    ~/.config/kitty/themes;

mkdir -p ~/.config/navi;
    symlink "$PWD"/navi.yml ~/.config/navi/config.yml

mkdir -p ~/.config/nix;
    symlink "$PWD"/nix.conf ~/.config/nix/nix.conf

echo ''
echo '-- BREW'
echo ''

! brew bundle check --global -v && \
    gum confirm "Run \`brew bundle install --global\`?" && \
    brew bundle install --global

if brew bundle cleanup --global | grep 'Would uninstall' > /dev/null; then
    echo ''
    brew bundle cleanup --global
    gum confirm "Run \`brew bundle cleanup --global --force\`?" && \
        brew bundle cleanup --global --force
fi

echo ''
echo '-- GENERAL CONFIG'
echo ''

if gum confirm "Configure git?"; then
    echo 'Setting gitignore_global excludes file'
    git config --global core.excludesfile ~/.gitignore_global

    echo ''
    echo 'Git user.name'
    git config --global user.name "$(
        gum input --placeholder 'Git user.name' --value "$(git config --global user.name)"
    )"
    git config --global user.name
    echo ''

    echo 'Git user email'
    git config --global user.email "$(
        gum input --placeholder 'Git user.email' --value "$(git config --global user.email)"
    )"
    git config --global user.email
    echo ''
fi

if ! git config --global alias.hack > /dev/null; then
    echo 'Adding git-town aliases'
    git-town alias true
    echo ''
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

    if gum confirm "Configure Macos Preferences?"; then
        # https://macos-defaults.com/
        # https://github.com/mathiasbynens/dotfiles/blob/main/.macos

        defaults write com.apple.dock "mineffect" -string "scale"
        defaults write com.apple.dock "tilesize" -int 36
        defaults write com.apple.dock "show-recents" -bool false
        # defaults write com.apple.dock "orientation" left
        defaults write com.apple.dock "autohide" -bool true
        defaults write com.apple.dock "autohide-delay" -float "0"
        defaults write com.apple.dock "autohide-time-modifier" -float "0"

        defaults write com.apple.finder "ShowPathbar" -bool true
        defaults write com.apple.finder "ShowStatusbar" -bool true
        # defaults write com.apple.finder "AppleShowAllFiles" -bool true

        defaults write com.apple.screencapture "type" -string "jpg"

        defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
        defaults write NSGlobalDomain "KeyRepeat" -int 2
        defaults write NSGlobalDomain "InitialKeyRepeat" -int 25
        defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool false

        # Finder: remove tags / recents, add home / library

        chflags nohidden ~/Library

        killall Finder
        killall Dock
    fi
fi

echo 'Manual actions'
echo ' - Install Bitwarden / Tailscale from App Store'
echo ' - Login to vscode settings sync'
echo ' - Install navi default and tldr repo'
echo ' - Setup Kitty opt+space shortcut key (via Shortcuts.app)'

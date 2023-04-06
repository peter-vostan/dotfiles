#!/usr/bin/env bash

set -e

function symlink() {
    echo "${2} -> ${1}"
    ln -snfF "${1}" "${2}"
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

if ! which rustup > /dev/null && gum confirm "Install rust?"; then
    echo 'Installing rust'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! [ -d ~/.oh-my-zsh ]; then
    echo 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo ''
echo '-- CREATING SYMLINKS'
echo ''

symlink "$PWD"/gitignore_global ~/.gitignore_global
symlink "$PWD"/zprofile ~/.zprofile
symlink "$PWD"/zshrc ~/.zshrc
symlink "$PWD"/zshenv ~/.zshenv

mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles;
    symlink "$PWD"/iterm2/profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/custom.json

echo ''
echo '-- BREW'
echo ''

! brew bundle check -v && \
    gum confirm "Run \`brew bundle install\`?" && \
    brew bundle install

if brew bundle cleanup | grep 'Would uninstall' > /dev/null; then
    echo ''
    brew bundle cleanup
    gum confirm "Run \`brew bundle cleanup --force\`?" && \
        brew bundle cleanup --force
fi

echo ''
echo '-- GENERAL CONFIG'
echo ''

if gum confirm "Configure git?"; then
    git config --global core.excludesfile ~/.gitignore_global
    git config --global push.autoSetupRemote true

    git config --global alias.hack "!bash -c \"shopt -s expand_aliases; . ${DOTFILES}/aliases && . ${DOTFILES}/functions && git-hack \$@\""
    git config --global alias.stash-all "!bash -c \". ${DOTFILES}/functions && git-stash-all\""
    git config --global alias.prune-branches "!bash -c \"shopt -s expand_aliases; . ${DOTFILES}/aliases && . ${DOTFILES}/functions && git-prune-branches\""

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

# OS specific config
if [[ "$OSTYPE" == "darwin"* ]]; then
    if gum confirm "Configure Macos Preferences?"; then
        # https://macos-defaults.com/
        # https://github.com/mathiasbynens/dotfiles/blob/main/.macos

        defaults write com.apple.dock "mineffect" -string "scale"
        defaults write com.apple.dock "tilesize" -int 36
        defaults write com.apple.dock "show-recents" -bool false
        # defaults write com.apple.dock "orientation" left
        # defaults write com.apple.dock "autohide" -bool true
        # defaults write com.apple.dock "autohide-delay" -float "0"
        # defaults write com.apple.dock "autohide-time-modifier" -float "0"

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

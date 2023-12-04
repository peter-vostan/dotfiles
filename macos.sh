#!/usr/bin/env bash

set -e

printf "\n -- MACOS SETUP \n"

if ! which brew > /dev/null; then
    printf "\n -- INSTALLING BREW \n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# brew bundle check
brew bundle install
brew bundle cleanup
# brew bundle cleanup --force

if ! [ -d ~/.oh-my-zsh ]; then
    printf "\n -- INSTALLING OH-MY-ZSH \n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

printf "\n -- ITERM2 PROFILE \n"

mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
symlink "$PWD"/iterm2/profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/custom.json

printf "\n -- MACOS SYSTEM CONFIG \n"

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

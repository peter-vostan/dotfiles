#!/usr/bin/env bash

# Apps
brew install --cask bitwarden
brew install --cask visual-studio-code
brew install --cask google-chrome
brew install --cask stats
brew install --cask rectangle
brew install --cask drawio
brew install --cask kap
brew install --cask microsoft-teams

# Terminal
brew install starship
brew install --cask fig                     # Fig app needs to be run manually to finish setup
brew install diff-so-fancy
brew install direnv
brew install navi                           # cheatsheets
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install httpie
brew install shellcheck

# Dev
brew install rustup-init; rustup-init -y
brew install fnm                            # Faster version of npm

# Virtualization
brew install podman
brew install --cask xquartz                 # Macos X11 for X11 port forwarding

# Cloud
brew install awscli
brew install azure-cli

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font

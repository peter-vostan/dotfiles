#!/usr/bin/env bash

defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock orientation left
defaults write com.apple.dock autohide -bool true

defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool true
defaults write NSGlobalDomain KeyRepeat -int 4
defaults write NSGlobalDomain InitialKeyRepeat -int 25

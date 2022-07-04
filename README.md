# Installation

## Install

```sh
# MACOS: Make sure Apple Command Line Tools are installed
xcode-select --install

# Run the installation script (this can be run multiple times without causing issues)
./install
```

Pay attention to the Post Install Instructions

Brew can be cleaned up by running the following (omit the --force to simply list what would be cleaned up)

```sh
brew bundle cleanup --global --force
```

## Optional Extras

### Nix

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Useful commands

```sh
# Devshell
nix develop nixpkgs#hello

# Garbage collection on the nix store
nix store gc

# List templates
nix flake show templates

# Initialize the current directory with the rust template
nix flake init -t templates#rust

# TODO: there doesn't seem to be a good template for a simple devshell flake.nix
```

### Brew

These are left out by default because they require rosetta `sudo softwareupdate --install-rosetta`

```sh
brew install --cask microsoft-teams
brew install --cask kap
```

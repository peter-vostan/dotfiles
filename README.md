# Installation

## Install Dependencies

```sh
# Install Apple Command Line Tools
xcode-select --install

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install nix package manager
sh <(curl -L https://nixos.org/nix/install)

sudo git/config.sh
brew/install-packages.sh
vscode/install-extensions.sh
```

## Install Dotfiles

```sh
./install
```

## Update Dotbot

```sh
git submodule update --remote dotbot
```

## Other

### Enable touch id for sudo

Add the following to `/etc/pam.d/sudo`

```
auth       sufficient     pam_tid.so
```

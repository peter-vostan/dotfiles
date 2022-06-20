# Installation

## Install Dependencies

```sh
# Install Apple Command Line Tools
xcode-select --install

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Insall brew packages
brew install --force $(cat brew/packages.txt)

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup git config
sudo git/config.sh

# Install vscode extensions
vscode/extensions.sh

# Install Nix ????
# sh <(curl -L https://nixos.org/nix/install) --daemon
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

## TODO

ssh config ?

docker-desktop (?? maybe not and use something different by default)

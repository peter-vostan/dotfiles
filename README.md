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

macos/preferences.sh
brew/install-packages.sh
vscode/install-extensions.sh
```

## Install Dotfiles

```sh
./install
```

## Other

### Enable touch id for sudo

Add the following to `/etc/pam.d/sudo`

```sh
auth       sufficient     pam_tid.so
```

### Podman

Running linux containers with x11 forwarding. `podmanrungui` is a custom function which runs the XQuartz app and sets up the correct podman args for x11 port forwarding

Example

```sh
podmanrungui -it ubuntu:20.04;
apt update; apt install x11-apps -y; xeyes;
```

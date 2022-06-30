# Installation

## Install

```sh
# Install Apple Command Line Tools
xcode-select --install

# Install Rosetta (currently required for microsoft-teams and kap)
sudo softwareupdate --install-rosetta

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

# Configure terminal profile (TODO: find a better way to do this)
# terminal -> Preferences -> Settings -> Profiles -> Default
#   -> Font -> FiraCode Nerd Font -> Regular -> 11
#   -> Cursor -> Vertical Bar
#   -> Cursor -> Blink cursor

# Fig: Open, grant permissions and setup with email
# Rectangle / Kap / Stats: Open and grant permissions

# Use dotbot to install dotfiles
./install
```

## Other

### Enable touch id for sudo

Add the following to `/etc/pam.d/sudo`

```sh
auth       sufficient     pam_tid.so
```

### Podman

When initializing the podman machine, mount the home directory for volume mounting to work

```sh
podman machine init -v $HOME:$HOME
```

podman-compose can be installed with `pip3 install podman-compose`

Running linux containers with x11 forwarding. `podmanrungui` is a custom function which runs the XQuartz app and sets up the correct podman args for x11 port forwarding

Example

```sh
podmanrungui -it ubuntu:20.04;
apt update; apt install x11-apps -y; xeyes;
```

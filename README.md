# dotfiles

Home Manager Docs: <https://rycee.gitlab.io/home-manager/options.html>

Nix Darwin Docs: <https://daiderd.com/nix-darwin/manual/index.html>

## Installation

```sh
# Install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable nix-command and flakes
echo "experimental-features = nix-command flakes" | sudo tee --append /etc/nix/nix.conf

# Copy the base64 encoded symmetric key for git-crypt and decode into ./secret-key file
pbpaste | base64 --decode > ./secret-key

# Decrypt secrets
nix run nixpkgs#git-crypt -- unlock ./secret-key
```

### MacOS

```sh
# Install homebrew (if not already installed) (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apply config in MacOS
nix run nix-darwin -- switch --flake .
```

### Linux (without NixOS)

```sh
# Apply config in Linux
nix run home-manager -- switch --flake .

# Update login shell (if required)
zsh
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

reboot
```

### NixOS

TODO: Add config / details

## Other

### Updating

To update the flake input refs (eg. bring in updates from nixpkgs-unstable)

```sh
nix flake update
```

### Dev shell templates

```sh
# https://github.com/NixOS/templates
nix flake init --template templates#full

# https://github.com/nix-community/templates
nix flake init --template github:nix-community/templates#<template>

# Use with direnv
echo "use flake" >> .envrc
direnv allow

# Ignore in shared repository
echo ".envrc" >> .git/info/exclude
echo "flake.nix" >> .git/info/exclude
```

### Package Hash Details

To get the hash details for a package, you can use a command like this

```sh
nix run nixpkgs#nix-prefetch-github -- {owner} {repo}
```

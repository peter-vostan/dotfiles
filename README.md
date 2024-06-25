# dotfiles

Home Manager Docs: <https://rycee.gitlab.io/home-manager/options.html>

Nix Darwin Docs: <https://daiderd.com/nix-darwin/manual/index.html>

## Installation

```sh
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# add nixpkgs-unstable channel
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update
```

Create a `settings.local.nix` file with the following content (update the placeholders)

```nix
{
  git.user = {
    name = "";
    email = "";
  };
}
```

### MacOS

```sh
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# add nix-darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer # N to editing the default config, Y to managing darwin with nix-channel

# Apply config in MacOS
darwin-rebuild switch -I darwin-config=profiles/darwin-XXXX.nix

# Add iterm2 profile to the DynamicProfiles directory (if not already done)
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
ln -snfF ~/dotfiles/iterm2-profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/custom.json
```

### Linux

```sh
# add home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# install home-manager
nix-shell '<home-manager>' -A install

# Apply config in linux
home-manager switch -f profiles/linux-XXXX.nix

# Update login shell (if required)
zsh
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s "$(which zsh)"
logout
```

If using a virtual machine on a macbook, use kinto.sh to setup better keyboard compatibility

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rbreaves/kinto/HEAD/install/linux.sh)"
# Not compatible with Wayland
# May need to disable default keybindings in virtualization software like Parallels
```

## Extra Packages

Some other usefull packages to use as needed

Brew

- `brew install --cask android-studio`
- `brew install --cask crystalfetch` UI for creating Windows installer ISO from UUPDump

Nix

-

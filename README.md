# dotfiles

Init submodules (used for omz plugins and navi cheats)

```sh
git submodule init
git submodule update
```

Bootstrap

- checks / installs dependencies
- creates symlinks for dotfiles
- [OPTIONAL] configures git
- [OPTIONAL] configures OS

```sh
./bootstrap.sh                 # follow the prompts
```

```sh
brew bundle check              # check for new brew dependencies
brew bundle install            # install new brew dependencies
brew bundle cleanup            # check for removed brew dependencies
brew bundle cleanup --force    # uninstall removed brew dependencies

git submodule update --remote  # pull submodule updates
```

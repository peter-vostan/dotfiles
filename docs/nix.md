# Nix

## Useful commands

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

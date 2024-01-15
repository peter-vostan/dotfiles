{ pkgs ? import <nixpkgs-unstable> {}}:

pkgs.mkShell {
  packages = with pkgs; [
    # (python3.withPackages (ps: with ps; [  ]))
    # hello
  ];
}

# Use with direnv
# echo "use nix" >> .envrc
# direnv allow

# Ignore in shared repository
# echo ".envrc" >> .git/info/exclude
# echo "shell.nix" >> .git/info/exclude

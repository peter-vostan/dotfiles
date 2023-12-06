{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./system-defaults.nix
  ];

  services.nix-daemon.enable = true; # Auto upgrade nix package and the daemon service.

  programs.zsh.enable = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}

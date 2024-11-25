{ config, pkgs, lib, ... }:

{
  imports = [
    ../home-manager/common.nix
    ../home-manager/gnome-terminal.nix
  ];

  nix.package = pkgs.nix;

  home.username = "peter";
  home.homeDirectory = "/home/peter";

  home.activation.updateFontCache = "/usr/bin/fc-cache -f"; # If this doesn't work run `fc-cache -f` manually instead
  home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
}

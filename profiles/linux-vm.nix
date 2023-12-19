{ config, pkgs, lib, ... }:

{
  imports = [ ../home-manager/common.nix ];

  home.username = "peter";
  home.homeDirectory = "/home/peter";

  home.activation.updateFontCache = "/usr/bin/fc-cache -f"; # If this doesn't work run `fc-cache -f` manually instead
  home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  programs.gnome-terminal = {
    enable = true;
    themeVariant = "dark";
    profile."b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      colors.backgroundColor = "rgb(23,20,33)";
      colors.foregroundColor = "rgb(208,207,204)";
      colors.palette = ["rgb(7,54,66)" "rgb(220,50,47)" "rgb(133,153,0)" "rgb(181,137,0)" "rgb(38,139,210)" "rgb(211,54,130)" "rgb(42,161,152)" "rgb(238,232,213)" "rgb(0,43,54)" "rgb(203,75,22)" "rgb(88,110,117)" "rgb(101,123,131)" "rgb(131,148,150)" "rgb(108,113,196)" "rgb(147,161,161)" "rgb(253,246,227)"];
      cursorShape = "ibeam";
      default = true;
      font = "JetBrainsMono Nerd Font Mono 12";
      visibleName = "Default";
    };
  };
}

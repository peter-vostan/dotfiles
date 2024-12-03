{ pkgs, ... }:

{
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";

  fonts.fontconfig.enable = true;
  home.activation.updateFontCache = "/usr/bin/fc-cache -f"; # If this doesn't work run `fc-cache -f` manually instead

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  programs.zsh.enable = true;
}

{ config, pkgs, lib, ... }:

{
  imports = [
    ./aliases.nix
    ./fzf.nix
    ./git.nix
    ./navi.nix
    ./starship.nix
    ./variables.nix
    ./zsh.nix
  ];

  home.file.".functions".source = ../functions;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    bottom curl fd ffmpeg git gum htop jq socat websocat
    fnm mkcert poetry
  ];

  programs.bat.enable = true;
  programs.bat.config.theme = "ansi";
  programs.broot.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.lsd.enable = true;
  programs.lsd.enableAliases = true;
}

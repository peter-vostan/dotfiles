{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./aliases.nix
    ./fzf.nix
    ./git.nix
    ./navi.nix
    ./starship.nix
    ./tmux.nix
    ./variables.nix
    ./zsh.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home.file.".functions".source = ../functions;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    nixpkgs-fmt
    nixd # nix language server 

    gum # used in shell functions
    jnv # json viewer and interactive jq filter editor
  ];

  programs.bat.enable = true;
  programs.bat.config.theme = "ansi";

  programs.broot.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = builtins.fromTOML ''
      [global]
      load_dotenv = true
    '';
  };

  programs.fd.enable = true;

  programs.jq.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings.date = "relative";
  };

  programs.ripgrep.enable = true;
}

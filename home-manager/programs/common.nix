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
    ./zsh.nix
  ];

  home.file.".functions".source = ../../functions;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono

    nixpkgs-fmt
    nixd # nix language server 

    gum # used in shell functions
    jnv # json viewer and interactive jq filter editor
  ];

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "nano";
    LESS = "iRFM";
    MANPAGER = "sh -c 'col -bx | bat -l man -p --paging=never'";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=240";
  };

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

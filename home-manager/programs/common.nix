{ pkgs, ... }:

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

    git-crypt

    nixfmt
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix

    gum # used in shell functions
    jnv # json viewer and interactive jq filter editor
  ];

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "nano";
    LESS =
      "iRFM"; # -i ignore case in searches that lack uppercase, -R display control chars, -F exit if less than 1 screen, -M prompt very verbosely
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
    settings.date = "relative";
  };

  programs.ripgrep.enable = true;
}

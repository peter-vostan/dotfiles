{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f --strip-cwd-prefix";
    defaultOptions = [
      "--color=fg:#d0d0d0,bg:#121212,hl:#5f87af"
      "--color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff"
      "--color=info:#afaf87,prompt:#d7005f,pointer:#af5fff"
      "--color=marker:#87ff00,spinner:#af5fff,header:#87afaf"
    ];
    fileWidgetCommand = "fd --type f --strip-cwd-prefix";
    fileWidgetOptions = [
      "--preview-window=right:60%"
      "--height=80%"
      "--preview='bat --color=always --style=\"plain\" {}'"
    ];
  };
}

{ config, pkgs, ... }:

{
  programs.navi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      finder.command = "fzf";
      style = {
        tag = {
          color = "blue";
          width_percentage = 20;
          min_width = 20;
        };
        comment = {
          color = "magenta";
          width_percentage = 50;
          min_width = 45;
        };
      };
    };
  };
}

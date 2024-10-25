{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    # https://alacritty.org/config-alacritty.html
    settings = {
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 14.0;
      keyboard.bindings = [
        { key = "Right"; mods = "Option"; chars = "\\u001BF"; }
        { key = "Left"; mods = "Option"; chars = "\\u001BB"; }

        { key = "Right"; mods = "Option|Command"; action = "SelectNextTab"; }
        { key = "Left"; mods = "Option|Command"; action = "SelectPreviousTab"; }
      ];
      window.opacity = 0.95;
      window.padding = { x = 4; y = 4; };
    };
  };
}

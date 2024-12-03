{ config, pkgs, lib, ... }:

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
      window.decorations_theme_variant = "Dark";
    };
  };

  # Spotlight does not index apps which are symlinked / aliased so we need to copy the .app instead
  home.activation.alacritty = lib.mkIf pkgs.stdenv.isDarwin (lib.hm.dag.entryAfter [ "writeBoundry" ] ''
    $DRY_RUN_CMD [ -e ~/Applications/Alacritty.app ] && rm -rf ~/Applications/Alacritty.app
    $DRY_RUN_CMD cp -r ${pkgs.alacritty}/Applications/Alacritty.app/ ~/Applications
    $DRY_RUN_CMD chmod -R 755 ~/Applications/Alacritty.app
    
    # Fix up the relative symlink
    $DRY_RUN_CMD ln -sf ${pkgs.alacritty}/bin ~/Applications/Alacritty.app/Contents/MacOS
  '');
}

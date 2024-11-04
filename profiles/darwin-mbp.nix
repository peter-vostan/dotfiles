{ config, pkgs, ... }:

{
  imports = [ ../darwin/common.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  environment.systemPackages = with pkgs; [ ];
  environment.pathsToLink = [
    "/share/zsh" # Needed for zsh completion of system commands
  ];

  users.users.peter = {
    name = "peter";
    home = "/Users/peter";
    shell = pkgs.zsh;
  };

  home-manager.users.peter = { pkgs, lib, ... }: {
    imports = [ ../home-manager/common.nix ];
    home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first

    # Spotlight does not index apps which are symlinked / aliased so we need to copy the .app instead
    home.activation.alacritty = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
      $DRY_RUN_CMD [ -e ~/Applications/Alacritty.app ] && rm -rf ~/Applications/Alacritty.app
      $DRY_RUN_CMD cp -r ${pkgs.alacritty}/Applications/Alacritty.app/ ~/Applications
      $DRY_RUN_CMD chmod -R 755 ~/Applications/Alacritty.app
      
      # Fix up the relative symlink
      $DRY_RUN_CMD ln -sf ${pkgs.alacritty}/bin ~/Applications/Alacritty.app/Contents/MacOS
    '';
  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    taps = [ ];
    brews = [
      "ansible"
      "awscli"
      "nats"
      "nomad"
      "packer"
      "terraform"
    ];
    casks = [
      "docker"
      "drawio"
      "microsoft-edge"
      "microsoft-teams"
      "visual-studio-code"
      "zed"
    ];
  };
}

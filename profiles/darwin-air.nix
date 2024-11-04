{ config, pkgs, ... }:

{
  imports = [ ../darwin/common.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  environment.systemPackages = with pkgs; [ ];
  environment.pathsToLink = [
    "/share/zsh" # Needed for zsh completion of system commands
  ];

  security.pam.enableSudoTouchIdAuth = true;

  networking.hostName = "peters-macbook-air";
  networking.knownNetworkServices = [ "Wi-Fi" ];
  networking.dns = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
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
    brews = [ ];
    casks = [
      "drawio"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "microsoft-teams"
      "messenger"
      "stremio"
      "utm"
      "visual-studio-code"
      "zed"
    ];
    # Mac App Store https://github.com/mas-cli/mas
    # $ mas search <app name>
    masApps = {
      "adguard-for-safari" = 1440147259;
      "bitwarden" = 1352778147;
    };
  };
}

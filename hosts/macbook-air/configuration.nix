{ pkgs, ... }:

{
  imports = [ ../darwin.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

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

  home-manager.users.peter = { ... }: {
    imports = [ ../../home-manager/programs/common.nix ];
    home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first
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

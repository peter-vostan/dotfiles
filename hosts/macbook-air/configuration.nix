{ pkgs, ... }:

{
  imports = [ ../darwin.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  security.pam.enableSudoTouchIdAuth = true;

  networking.hostName = "peters-macbook-air";

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
    brews = [
      "uv" # Fast Python package and project manager, written in Rust
    ];
    casks = [
      "drawio"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "microsoft-teams"
      "messenger"
      "netspot"
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

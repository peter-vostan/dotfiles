{ config, pkgs, ... }:

{
  imports = [ ../darwin/common.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [];

  security.pam.enableSudoTouchIdAuth = true;

  users.users.peter = {
    name = "peter";
    home = "/Users/peter";
    shell = pkgs.zsh;
  };

  home-manager.users.peter = { pkgs, ... }: {
    imports = [ ../home-manager/common.nix ];
    home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first
  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    taps = [];
    brews = [];
    casks = [
      "android-studio"
      "crystalfetch"        # UI for creating Windows installer ISO from UUPDump
      "drawio"
      "firefox"
      "google-chrome"
      "iterm2"
      "microsoft-edge"
      "microsoft-teams"
      "messenger"
      "rectangle"
      "stremio"
      "utm"
      "visual-studio-code"
      "vpn-by-google-one"
    ];
  };
}

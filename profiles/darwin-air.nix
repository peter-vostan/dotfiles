{ config, pkgs, ... }:

{
  imports = [ ../darwin/common.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  environment.systemPackages = with pkgs; [];

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
    taps = [
      "azure/functions"
      "homebrew/cask"
      "stripe/stripe-cli"
    ];
    brews = [
      "awscli"
      "azure-cli"
      "azure-functions-core-tools@4"
      "stripe"
      "terraform"
    ];
    casks = [
      "android-studio"
      "drawio"
      "firefox"
      "google-chrome"
      "iterm2"
      "microsoft-edge"
      "microsoft-teams"
      "messenger"
      "rectangle"
      "stremio"
      "visual-studio-code"
      "vpn-by-google-one"
    ];
  };
}

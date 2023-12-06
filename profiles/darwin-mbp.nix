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
      "homebrew/cask"
    ];
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
      "iterm2"
      "microsoft-edge"
      "microsoft-teams"
      "rectangle"
      "visual-studio-code"
    ];
  };
}

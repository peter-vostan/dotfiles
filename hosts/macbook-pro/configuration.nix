{ pkgs, secrets, ... }:

{
  imports = [ ../darwin.nix ];

  system.stateVersion = 4; # Used for backwards compatibility, please read the changelog before changing. ($ darwin-rebuild changelog)

  users.users.peter = {
    name = "peter";
    home = "/Users/peter";
    shell = pkgs.zsh;
  };

  home-manager.users.peter = { ... }: {
    imports = [ ../../home-manager/programs/common.nix ];
    home.stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first

    programs.git.userName = secrets.github.name;
    programs.git.userEmail = secrets.github.email.work;
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
      "uv" # Fast Python package and project manager, written in Rust
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

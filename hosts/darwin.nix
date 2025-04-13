{ ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
  environment.pathsToLink = [
    "/share/zsh" # Needed for zsh completion of system commands
  ];

  # https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults
  system.defaults = {
    CustomUserPreferences = {
      "~/Library/Preferences/ByHost/com.apple.controlcenter.plist" = {
        "Bluetooth" = 18;
        "BatteryShowPercentage" = 1;
      };
    };

    dock = {
      mineffect = "scale";
      minimize-to-application =
        true; # Minimize windows into their application's icon, might need to be manually applied if this isn't working
      tilesize = 36;
      show-recents = false;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
    };

    finder = {
      FXDefaultSearchScope = "SCcf"; # Search current folder
      FXPreferredViewStyle = "Nlsv"; # List view
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    menuExtraClock = {
      ShowDayOfWeek = false;
      ShowSeconds = false;
    };

    screencapture.type = "jpg";

    trackpad = {
      Clicking =
        true; # Enable tap to click, might need to be manually applied if this isn't working
      # Manually turn "Look up and Data Detectors" off in System Preferences > Trackpad > Point & Click
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 25;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}

{ config, pkgs, ... }:

{
  system.defaults = {
    dock = {
      mineffect = "scale";
      tilesize = 36;
      show-recents = false;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
    };

    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    screencapture.type = "jpg";

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 25;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}

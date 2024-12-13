{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    aliases = {
      "prune-branches" = "!bash -c \"source $HOME/.functions && git-prune-branches\"";
      "exclude" = "!$EDITOR .git/info/exclude";
    };
    ignores = [
      ".DS_Store"
      ".DS_Store?"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      ".$*" # drawio temp files
      ".idea"
      ".notes"
      ".direnv/"
    ];
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };
}

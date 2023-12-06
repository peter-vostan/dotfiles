{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    aliases = {
      # TODO: this probably won't work as is. See how the .zshrc and other files are created and refactor from there
      "prune-branches" = "!bash -c \"shopt -s expand_aliases; . $HOME/aliases && . $HOME/functions && git-prune-branches\"";
    };
    ignores = [
      ".DS_Store" ".DS_Store?" ".Spotlight-V100" ".Trashes" "ehthumbs.db" "Thumbs.db"
      ".$*" # drawio temp files
      ".idea" ".notes"
    ];
    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = false;
    };
  };
}

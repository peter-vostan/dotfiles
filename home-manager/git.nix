{ config, pkgs, ... }:

let
  settings = (import ../settings.local.nix);
in
{
  programs.git = {
    enable = true;
    userName = settings.git.user.name;
    userEmail = settings.git.user.email;
    aliases = {
      "prune-branches" = "!bash -c \"source $HOME/.functions && git-prune-branches\"";
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

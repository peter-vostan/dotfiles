{ config, pkgs, ... }:

{
  home.shellAliases = {
    cat = "bat --paging=never --style=plain";
    dua = "broot -w"; # dua alternatove using broot
    path = "echo $PATH | tr -s \":\" \"\n\"";
    fpath = "echo $FPATH | tr -s \":\" \"\n\"";
    lowercase = "tr '[:upper:]' '[:lower:]'";
    uppercase = "tr '[:lower:]' '[:upper:]'";
  };
}

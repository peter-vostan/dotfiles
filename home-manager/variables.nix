{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "nano";
    LESS = "iRFM";
    MANPAGER = "sh -c 'col -bx | bat -l man -p --paging=never'";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=240"; # TODO: is this actually needed?
  };
}

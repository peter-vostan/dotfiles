{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all";
      character.success_symbol = "[↳]()";
      character.error_symbol = "[↳](red)";
      git_branch.symbol = " ";
      hostname.ssh_only = true;
      hostname.format = "[\[$hostname\]]($style) "; # Looks better without the symbol
      package.disabled = true; # Package version is rarely useful
      nix_shell.format = "via [$symbol$name]($style) "; # remove pure/impure
    };
  };
}

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
      git_status.disabled = true; # Causes a lot of lag
      hostname.ssh_only = true;
      hostname.format = "[\[$hostname\]]($style) "; # Looks better without the symbol
      package.disabled = true; # Package version is rarely useful
      nix_shell.format = "via [$name]($style) "; # remove symbol and pure/impure
    };
  };
}

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all";
      character.success_symbol = "[↳]()";
      character.error_symbol = "[↳](red)";
      directory.read_only = " "; # TODO: review this
      git_branch.symbol = " ";
      hostname.ssh_only = true;
      hostname.format = "[\[$hostname\]]($style) "; # Looks better without the symbol
      package.disabled = true; # Package version is rarely useful
    };
  };
}

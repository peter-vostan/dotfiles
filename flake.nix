{
  description = "nix-configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs }:
    {
      # $ darwin-rebuild switch --flake .
      darwinConfigurations = {
        "Peters-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.default
            ./hosts/macbook-pro/configuration.nix
          ];
        };
        "peters-macbook-air" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.default
            ./hosts/macbook-air/configuration.nix
          ];
        };
      };

      # $ home-manager switch --flake .
      homeConfigurations = {
        "peter" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "aarch64-linux"; };
          modules = [
            ./home-manager/linux-standalone.nix
            {
              imports = [
                ./home-manager/programs/common.nix
                ./home-manager/programs/gnome-terminal.nix
              ];

              home = {
                username = "peter";
                homeDirectory = "/home/peter";
                stateVersion = "23.11"; # Be careful changing this. Check Home Manager release notes thoroughly first
              };
            }
          ];
        };
      };
    };
}

{
  description = "Hydra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations."Hydra" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/Hydra/darwin-configuration.nix

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kr4xkan = import ./hosts/Hydra/home.nix;
        }
      ];
    };
  };
}

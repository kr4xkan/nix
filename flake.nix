{
  description = "Hydra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin }: {
    darwinConfigurations."Hydra" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/Hydra/darwin-configuration.nix
      ];
    };
  };
}

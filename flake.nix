{
  description = "Starter Configuration for macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib.extend (
        self: super: {
          alex = import ./lib { lib = self; };
        }
      );
    in
    {
      darwinConfigurations."ab-mbp-m3" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/ab-mbp-m3/configuration.nix
        ];
      };

      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/nixos-vm/configuration.nix
        ];
      };

      nixosConfigurations."homeserver" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/homeserver/configuration.nix
        ];
      };
    };
}

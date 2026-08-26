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

      mkHome =
        {
          system,
          user,
          modules,
        }:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs user; };
          inherit modules;
        };
    in
    {
      darwinConfigurations."ab-mbp-m3" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/ab-mbp-m3.nix
        ];
      };

      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/nixos-vm.nix
        ];
      };

      homeConfigurations = {
        "ab@ab-mbp-m3" = mkHome {
          system = "aarch64-darwin";
          user = {
            name = "ab";
            homeDir = "/Users/ab";
          };
          modules = [ ./profiles/home/ab-mbp-m3.nix ];
        };

        "alex@nixos-vm" = mkHome {
          system = "aarch64-linux";
          user = {
            name = "alex";
            homeDir = "/home/alex";
          };
          modules = [ ./profiles/home/nixos-vm.nix ];
        };
      };

      homeModules = {
        common = ./modules/home/common.nix;
        dms = import ./modules/home/dms.nix { inherit inputs; };
        niri = import ./modules/home/niri.nix { inherit inputs; };
        noctalia = import ./modules/home/noctalia.nix { inherit inputs; };
      };
    };
}

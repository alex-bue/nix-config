{
  description = "macOS, NixOS, and Home Manager configurations";

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

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems = lib.genAttrs systems;

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
          ./hosts/ab-mbp-m3
        ];
      };

      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs lib; };
        modules = [
          ./hosts/nixos-vm
        ];
      };

      homeConfigurations = {
        "ab@personal-wsl" = mkHome {
          system = "x86_64-linux";
          user = {
            name = "ab";
            homeDir = "/home/ab";
            alias = "Alexander Büscher";
            email = "alexanderbuescher@outlook.com";
          };
          modules = [ ./homes/personal.nix ];
        };
      };

      homeModules = {
        aerospace = ./modules/home/aerospace.nix;
        cli = ./modules/home/cli.nix;
        development = ./modules/home/development.nix;
        dms = import ./modules/home/dms.nix { inherit inputs; };
        ghostty = ./modules/home/ghostty.nix;
        git = ./modules/home/git.nix;
        niri = import ./modules/home/niri.nix { inherit inputs; };
        noctalia = import ./modules/home/noctalia.nix { inherit inputs; };
        shell = ./modules/home/shell.nix;
        tmux = ./modules/home/tmux.nix;
        wezterm = ./modules/home/wezterm.nix;
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          formatting = pkgs.runCommand "check-nix-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
            cp -r ${./.} source
            chmod -R +w source
            find source -name '*.nix' \
              ! -path 'source/hosts/nixos-vm/hardware-configuration.nix' \
              -print0 | xargs -0 nixfmt --check
            touch $out
          '';
        }
      );
    };
}

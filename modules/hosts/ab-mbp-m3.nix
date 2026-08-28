{ config, inputs, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.modules.darwin.ab-mbp-m3 = {
    imports = [
      darwin.alexander
      darwin.home-manager
      darwin.homebrew
      darwin.nix
      darwin.fonts
      darwin.darwin-defaults
      darwin.personal-desktop
    ];
    home-manager.users.ab = {
      imports = [
        homeManager.alexander
        homeManager.personal-desktop
      ];
      home.username = "ab";
      home.homeDirectory = "/Users/ab";
    };
    networking.hostName = "ab-mbp-m3";
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 5;
  };

  flake.darwinConfigurations.ab-mbp-m3 = inputs.nix-darwin.lib.darwinSystem {
    modules = [ darwin.ab-mbp-m3 ];
  };
}

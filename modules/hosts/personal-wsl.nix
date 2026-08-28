{ config, inputs, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.personal-wsl = {
    imports = [
      homeManager.alexander
      homeManager.development
    ];
    home.username = "ab";
    home.homeDirectory = "/home/ab";
  };

  flake.homeConfigurations."ab@personal-wsl" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    modules = [ homeManager.personal-wsl ];
  };
}

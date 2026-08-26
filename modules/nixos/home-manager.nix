{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (config.mine) user;
  cfg = user.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkIf cfg.enable {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {
        inherit inputs user;
      };
    };
  };
}

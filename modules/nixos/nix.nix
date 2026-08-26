{ lib, config, ... }:
let
  cfg = config.mine.system.nix;
in
{
  options.mine.system.nix.enable = lib.mkEnableOption "Nix settings";

  config = lib.mkIf cfg.enable {
    nix = {
      enable = true;
      settings = {
        experimental-features = "nix-command flakes";
        warn-dirty = false;
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}

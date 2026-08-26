{ lib, config, ... }:
let
  cfg = config.mine.apps.raycast;
in
{
  options.mine.apps.raycast.enable = lib.mkEnableOption "Install Raycast";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "raycast" ];
  };
}

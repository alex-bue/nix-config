{ lib, config, ... }:
let
  cfg = config.mine.system.networking.networkmanager;
in
{
  options.mine.system.networking.networkmanager.enable = lib.mkEnableOption "NetworkManager";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}

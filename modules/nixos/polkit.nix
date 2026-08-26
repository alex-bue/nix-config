{ lib, config, ... }:
let
  cfg = config.mine.system.services.polkit;
in
{
  options.mine.system.services.polkit.enable = lib.mkEnableOption "PolicyKit";

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
  };
}

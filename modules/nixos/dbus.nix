{ lib, config, ... }:
let
  cfg = config.mine.system.services.dbus;
in
{
  options.mine.system.services.dbus.enable = lib.mkEnableOption "D-Bus";

  config = lib.mkIf cfg.enable {
    services.dbus.enable = true;
  };
}

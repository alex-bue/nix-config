{ lib, config, ... }:
let
  cfg = config.mine.system.services.keyring;
in
{
  options.mine.system.services.keyring.enable = lib.mkEnableOption "GNOME Keyring";

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}

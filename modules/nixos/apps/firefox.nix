{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.apps.firefox;
in
{
  options.mine.apps.firefox.enable = lib.mkEnableOption "Install Firefox";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.firefox
    ];
  };
}

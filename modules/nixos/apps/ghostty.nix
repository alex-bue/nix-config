{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.apps.ghostty;
in
{
  options.mine.apps.ghostty.enable = lib.mkEnableOption "Install Ghostty";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ghostty
    ];
  };
}

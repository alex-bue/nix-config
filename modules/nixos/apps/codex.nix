{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.apps.codex;
in
{
  options.mine.apps.codex.enable = lib.mkEnableOption "Install Codex";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.codex
    ];
  };
}

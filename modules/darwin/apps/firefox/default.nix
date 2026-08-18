{ lib, config, ... }:
let
  cfg = config.mine.apps.firefox;
in
{
  options.mine.apps.firefox.enable = lib.mkEnableOption "Install Firefox";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "firefox" ];
  };
}

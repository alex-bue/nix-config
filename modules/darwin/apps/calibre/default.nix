{ lib, config, ... }:
let
  cfg = config.mine.apps.calibre;
in
{
  options.mine.apps.calibre.enable = lib.mkEnableOption "Install Calibre";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "calibre" ];
  };
}

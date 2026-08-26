{ lib, config, ... }:
let
  cfg = config.mine.apps.onedrive;
in
{
  options.mine.apps.onedrive.enable = lib.mkEnableOption "Install OneDrive";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "onedrive" ];
  };
}

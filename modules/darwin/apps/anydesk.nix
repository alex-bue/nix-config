{ lib, config, ... }:
let
  cfg = config.mine.apps.anydesk;
in
{
  options.mine.apps.anydesk.enable = lib.mkEnableOption "Install AnyDesk";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "anydesk" ];
  };
}

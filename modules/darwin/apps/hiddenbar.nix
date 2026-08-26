{ lib, config, ... }:
let
  cfg = config.mine.apps.hiddenbar;
in
{
  options.mine.apps.hiddenbar.enable = lib.mkEnableOption "Install HiddenBar";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "hiddenbar" ];
  };
}

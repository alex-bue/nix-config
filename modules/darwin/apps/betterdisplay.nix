{ lib, config, ... }:
let
  cfg = config.mine.apps.betterdisplay;
in
{
  options.mine.apps.betterdisplay.enable = lib.mkEnableOption "Install BetterDisplay";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "betterdisplay" ];
  };
}

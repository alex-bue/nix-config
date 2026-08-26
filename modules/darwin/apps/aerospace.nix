{ lib, config, ... }:
let
  cfg = config.mine.apps.aerospace;
in
{
  options.mine.apps.aerospace.enable = lib.mkEnableOption "Install AeroSpace";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "nikitabobko/tap/aerospace" ];
  };
}

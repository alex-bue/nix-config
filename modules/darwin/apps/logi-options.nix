{ lib, config, ... }:
let
  cfg = config.mine.apps.logiOptions;
in
{
  options.mine.apps.logiOptions.enable = lib.mkEnableOption "Install logi-options";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "logi-options+" ];
  };
}

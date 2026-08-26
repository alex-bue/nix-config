{ lib, config, ... }:
let
  cfg = config.mine.apps.ghostty;
in
{
  options.mine.apps.ghostty.enable = lib.mkEnableOption "Install Ghostty";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "ghostty" ];
  };
}

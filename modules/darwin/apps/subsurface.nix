{ lib, config, ... }:
let
  cfg = config.mine.apps.subsurface;
in
{
  options.mine.apps.subsurface.enable = lib.mkEnableOption "Install Subsurface";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "subsurface" ];
  };
}

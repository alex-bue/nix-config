{ lib, config, ... }:
let
  cfg = config.mine.apps.iina;
in
{
  options.mine.apps.iina.enable = lib.mkEnableOption "Install IINA";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "iina" ];
  };
}

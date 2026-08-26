{ lib, config, ... }:
let
  cfg = config.mine.apps.bitwarden;
in
{
  options.mine.apps.bitwarden.enable = lib.mkEnableOption "Install Bitwarden";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "bitwarden" ];
  };
}

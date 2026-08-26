{ lib, config, ... }:
let
  cfg = config.mine.apps.googleChrome;
in
{
  options.mine.apps.googleChrome.enable = lib.mkEnableOption "Install Google Chrome";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "google-chrome" ];
  };
}

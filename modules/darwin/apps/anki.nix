{ lib, config, ... }:
let
  cfg = config.mine.apps.anki;
in
{
  options.mine.apps.anki.enable = lib.mkEnableOption "Install Anki";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "anki" ];
  };
}

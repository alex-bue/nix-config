{ lib, config, ... }:
let
  cfg = config.mine.apps.alfred;
in
{
  options.mine.apps.alfred.enable = lib.mkEnableOption "Install Alfred";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "alfred" ];
  };
}

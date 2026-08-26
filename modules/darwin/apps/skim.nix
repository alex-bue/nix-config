{ lib, config, ... }:
let
  cfg = config.mine.apps.skim;
in
{
  options.mine.apps.skim.enable = lib.mkEnableOption "Install Skim";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "skim" ];
  };
}

{ lib, config, ... }:
let
  cfg = config.mine.apps.dbeaverCommunity;
in
{
  options.mine.apps.dbeaverCommunity.enable = lib.mkEnableOption "Install DBeaver Community";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "dbeaver-community" ];
  };
}

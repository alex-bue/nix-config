{ lib, config, ... }:
let
  cfg = config.mine.apps.zotero;
in
{
  options.mine.apps.zotero.enable = lib.mkEnableOption "Install Zotero";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "zotero" ];
  };
}

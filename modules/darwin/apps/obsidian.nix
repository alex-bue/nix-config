{ lib, config, ... }:
let
  cfg = config.mine.apps.obsidian;
in
{
  options.mine.apps.obsidian.enable = lib.mkEnableOption "Install Obsidian";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "obsidian" ];
  };
}

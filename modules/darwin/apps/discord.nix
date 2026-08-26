{ lib, config, ... }:
let
  cfg = config.mine.apps.discord;
in
{
  options.mine.apps.discord.enable = lib.mkEnableOption "Install Discord";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "discord" ];
  };
}

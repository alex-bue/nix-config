{ lib, config, ... }:
let
  cfg = config.mine.apps.spotify;
in
{
  options.mine.apps.spotify.enable = lib.mkEnableOption "Install Spotify";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "spotify" ];
  };
}

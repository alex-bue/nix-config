{ lib, config, ... }:
let
  cfg = config.mine.apps.dockerDesktop;
in
{
  options.mine.apps.dockerDesktop.enable = lib.mkEnableOption "Install Docker Desktop";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "docker-desktop" ];
  };
}

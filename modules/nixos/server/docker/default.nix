{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.server.docker;
in
{
  options.mine.server.docker.enable = lib.mkEnableOption "Docker server runtime";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.docker-compose
    ];

    systemd.tmpfiles.rules = [
      "d /srv/docker 0755 root root -"
    ];

    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}

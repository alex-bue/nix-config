{ lib, config, ... }:
let
  cfg = config.mine.server.apps.bookorbit;
  baseDir = "/srv/docker/bookorbit";
in
{
  options.mine.server.apps.bookorbit.enable = lib.mkEnableOption "BookOrbit Compose stack";

  config = lib.mkIf cfg.enable {
    mine.server.composeStacks.bookorbit = {
      enable = true;
      composeFile = ./compose.yml;
      envFile = "${baseDir}/.env";
      workingDirectory = baseDir;
    };

    systemd.tmpfiles.rules = [
      "d ${baseDir} 0750 root root -"
      "d ${baseDir}/books 0750 1000 1000 -"
      "d ${baseDir}/data 0750 root root -"
      "d ${baseDir}/data/app 0750 1000 1000 -"
      "d ${baseDir}/data/postgres 0700 999 999 -"
    ];
  };
}

{ lib, config, ... }:
let
  cfg = config.mine.server.apps.homebox;
  baseDir = "/srv/docker/homebox";
in
{
  options.mine.server.apps.homebox.enable = lib.mkEnableOption "Homebox Compose stack";

  config = lib.mkIf cfg.enable {
    mine.server.composeStacks.homebox = {
      enable = true;
      composeFile = ./compose.yml;
      envFile = "${baseDir}/.env";
      workingDirectory = baseDir;
    };

    systemd.tmpfiles.rules = [
      "d ${baseDir} 0750 root root -"
      "d ${baseDir}/data 0750 root root -"
    ];
  };
}

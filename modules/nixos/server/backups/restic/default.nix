{ lib, config, ... }:
let
  cfg = config.mine.server.backups.restic;
in
{
  options.mine.server.backups.restic.enable = lib.mkEnableOption "Restic backups";

  config = lib.mkIf cfg.enable {
    services.restic.backups.homeserver = {
      initialize = true;
      passwordFile = "/srv/secrets/restic/password";
      paths = [
        "/srv/docker"
      ];
      repository = "/mnt/backup/restic/homeserver";
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
      timerConfig = {
        OnCalendar = "03:15";
        Persistent = true;
      };
    };

    systemd.tmpfiles.rules = [
      "d /srv/secrets/restic 0700 root root -"
      "d /mnt/backup/restic 0750 root root -"
    ];
  };
}

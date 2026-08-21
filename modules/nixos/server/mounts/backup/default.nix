{ lib, config, ... }:
let
  cfg = config.mine.server.mounts.backup;
in
{
  options.mine.server.mounts.backup.enable = lib.mkEnableOption "external backup drive mount";

  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/backup" = {
      device = "/dev/disk/by-uuid/29c22ce5-a027-481f-a5ef-04edb2919e88";
      fsType = "ext4";
      options = [
        "nofail"
        "x-systemd.automount"
        "x-systemd.idle-timeout=10min"
      ];
    };
  };
}

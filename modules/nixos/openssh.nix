{ lib, config, ... }:
let
  cfg = config.mine.system.services.openssh;
in
{
  options.mine.system.services.openssh.enable = lib.mkEnableOption "OpenSSH service";

  config = lib.mkIf cfg.enable {
    services.openssh.enable = true;
  };
}

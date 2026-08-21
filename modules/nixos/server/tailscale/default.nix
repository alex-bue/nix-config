{ lib, config, ... }:
let
  cfg = config.mine.server.tailscale;
in
{
  options.mine.server.tailscale.enable = lib.mkEnableOption "Tailscale";

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;

    networking.firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
    };
  };
}

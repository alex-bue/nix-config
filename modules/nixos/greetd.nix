{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.desktop.greetd;
in
{
  options.mine.desktop.greetd.enable =
    lib.mkEnableOption "Enable greetd with tuigreet for niri-session";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };
  };
}

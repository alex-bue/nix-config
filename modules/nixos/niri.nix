{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.desktop.niri;
in
{
  options.mine.desktop.niri.enable = lib.mkEnableOption "Enable Niri window manager";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      fuzzel
    ];
  };
}

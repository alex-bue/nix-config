{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.apps.wezterm;
in
{
  options.mine.apps.wezterm.enable = lib.mkEnableOption "Install WezTerm";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wezterm
    ];
  };
}

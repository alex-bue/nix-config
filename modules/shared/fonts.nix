{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.system.fonts;
in
{
  options.mine.system.fonts.enable = lib.mkEnableOption "shared fonts";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}

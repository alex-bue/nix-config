{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.cli-tools.git;
in
{
  options.mine.cli-tools.git.enable = lib.mkEnableOption "Install Git";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      gh
    ];
  };
}

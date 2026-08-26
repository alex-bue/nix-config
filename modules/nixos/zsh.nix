{ lib, config, ... }:
let
  cfg = config.mine.system.shell.zsh;
in
{
  options.mine.system.shell.zsh.enable = lib.mkEnableOption "Zsh shell";

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
  };
}

{ lib, config, ... }:
let
  cfg = config.mine.apps.codex;
in
{
  options.mine.apps.codex.enable = lib.mkEnableOption "Install Codex";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "codex" ];
  };
}

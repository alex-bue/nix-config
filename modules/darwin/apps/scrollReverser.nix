{ lib, config, ... }:
let
  cfg = config.mine.apps.scrollReverser;
in
{
  options.mine.apps.scrollReverser.enable = lib.mkEnableOption "Install Scroll Reverser";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "scroll-reverser" ];
  };
}

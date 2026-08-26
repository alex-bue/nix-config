{ lib, config, ... }:
let
  cfg = config.mine.apps.karabinerElements;
in
{
  options.mine.apps.karabinerElements.enable = lib.mkEnableOption "Install Karabiner-Elements";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "karabiner-elements" ];
  };
}

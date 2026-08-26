{ lib, config, ... }:
let
  cfg = config.mine.apps.visualStudioCode;
in
{
  options.mine.apps.visualStudioCode.enable = lib.mkEnableOption "Install Visual Studio Code";

  config = lib.mkIf cfg.enable {
    homebrew.casks = lib.mkAfter [ "visual-studio-code" ];
  };
}

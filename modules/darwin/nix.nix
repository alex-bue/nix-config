{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.mine.system.nix;
in
{
  imports = [
    inputs.determinate.darwinModules.default
  ];

  options.mine.system.nix.enable = lib.mkEnableOption "darwin nix settings";

  config = lib.mkIf cfg.enable {
    determinateNix = {
      enable = true;
      determinateNixd.builder.state = "enabled";
      customSettings = {
        experimental-features = "nix-command flakes";
        extra-experimental-features = "parallel-eval";
        warn-dirty = false;
      };
    };

    system.checks.verifyNixPath = false;
  };
}

{ lib, ... }:
let
  inherit (lib.alex) enabled;
in
{
  imports = [
    ../modules/darwin/apps/communication.nix
    ../modules/darwin/apps/development.nix
    ../modules/darwin/apps/media.nix
    ../modules/darwin/apps/productivity.nix
    ../modules/darwin/apps/system.nix
    ../modules/darwin/defaults.nix
    ../modules/darwin/nix.nix
  ];

  mine = {
    cli-tools.homebrew = enabled;
    system = {
      defaults = enabled;
      nix = enabled;
    };
  };
}

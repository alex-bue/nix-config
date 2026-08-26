{ lib, ... }:
let
  inherit (lib.alex) enabled;
in
{
  imports = [
    ../modules/shared
  ];

  mine = {
    user.home-manager = enabled;
    system.fonts = enabled;
  };
}

{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.gui = {
    imports = [
      homeManager.base
      homeManager.ghostty
      homeManager.wezterm
    ];
  };
}

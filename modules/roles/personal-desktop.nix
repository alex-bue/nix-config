{ config, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.modules.darwin.personal-desktop = {
    imports = [
      darwin.development
      darwin.aerospace
      darwin.ghostty
      darwin.wezterm
      darwin.alfred
      darwin.anydesk
      darwin.anki
      darwin.betterdisplay
      darwin.bitwarden
      darwin.calibre
      darwin.chrome
      darwin.discord
      darwin.firefox
      darwin.iina
      darwin.karabiner-elements
      darwin.logi-options
      darwin.obsidian
      darwin.raycast
      darwin.scroll-reverser
      darwin.skim
      darwin.spotify
      darwin.steam
      darwin.subsurface
      darwin.zotero
    ];
  };
  flake.modules.homeManager.personal-desktop = {
    imports = [
      homeManager.development
      homeManager.aerospace
      homeManager.ghostty
      homeManager.wezterm
    ];
  };
}

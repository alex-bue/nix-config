{ config, inputs, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.modules.darwin.ab-mbp-m3 = {
    imports = [
      darwin.alexander
      darwin.home-manager
      darwin.homebrew
      darwin.nix
      darwin.fonts
      darwin.darwin-defaults
      darwin.dbeaver
      darwin.docker-desktop
      darwin.vscode
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
    home-manager.users.ab = {
      imports = [
        homeManager.alexander
        homeManager.gui
        homeManager.aerospace
      ];
      home.username = "ab";
      home.homeDirectory = "/Users/ab";
    };
    networking.hostName = "ab-mbp-m3";
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 5;
  };

  flake.darwinConfigurations.ab-mbp-m3 = inputs.nix-darwin.lib.darwinSystem {
    modules = [ darwin.ab-mbp-m3 ];
  };
}

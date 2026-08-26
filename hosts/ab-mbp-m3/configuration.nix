{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.alex) enabled disabled;
in
{
  imports = [
    ../../modules/darwin
    ../../modules/shared
  ];

  config = {
    home-manager.users.${config.mine.user.name}.imports = [
      ../../profiles/home/ab-mbp-m3.nix
    ];

    networking.hostName = "ab-mbp-m3";
    nixpkgs.hostPlatform = "aarch64-darwin";

    system = {
      primaryUser = config.mine.user.name;
      stateVersion = 5;
    };

    mine = {
      user = {
        enable = true;
        name = "ab";
        homeDir = "/Users/ab";
        home-manager.enable = true;
        shell.package = pkgs.zsh;
      };
      cli-tools.homebrew = enabled;
      apps = {
        aerospace = enabled;
        alfred = enabled;
        anki = enabled;
        anydesk = enabled;
        betterdisplay = enabled;
        bitwarden = enabled;
        calibre = enabled;
        codex = enabled;
        dbeaverCommunity = enabled;
        discord = enabled;
        dockerDesktop = enabled;
        firefox = enabled;
        ghostty = enabled;
        googleChrome = enabled;
        hiddenbar = disabled;
        iina = enabled;
        karabinerElements = enabled;
        logiOptions = enabled;
        obsidian = enabled;
        onedrive = disabled;
        raycast = enabled;
        scrollReverser = enabled;
        skim = enabled;
        spotify = enabled;
        steam = enabled;
        subsurface = enabled;
        visualStudioCode = enabled;
        wezterm = enabled;
        zotero = enabled;
      };
      system = {
        defaults = enabled;
        nix = enabled;
        fonts = enabled;
        utils = enabled;
      };
    };
  };
}

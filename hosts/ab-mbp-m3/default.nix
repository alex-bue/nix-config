{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.alex) enabled;
in
{
  imports = [
    ../../modules/darwin
    ../../modules/shared
    ../../modules/darwin/apps/communication.nix
    ../../modules/darwin/apps/development.nix
    ../../modules/darwin/apps/media.nix
    ../../modules/darwin/apps/productivity.nix
    ../../modules/darwin/apps/system.nix
    ../../modules/darwin/defaults.nix
    ../../modules/darwin/nix.nix
  ];

  home-manager.users.${config.mine.user.name}.imports = [
    ../../homes/darwin.nix
  ];

  networking.hostName = "ab-mbp-m3";
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    primaryUser = config.mine.user.name;
    stateVersion = 5;
  };

  mine = {
    cli-tools.homebrew = enabled;

    system = {
      defaults = enabled;
      fonts = enabled;
      nix = enabled;
    };

    user = {
      enable = true;
      name = "ab";
      alias = "Alexander Büscher";
      email = "alexanderbuescher@outlook.com";
      homeDir = "/Users/ab";
      home-manager = enabled;
      shell.package = pkgs.zsh;
    };
  };
}

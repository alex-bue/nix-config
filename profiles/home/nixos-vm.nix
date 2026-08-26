{ user, ... }:
{
  imports = [
    ../../modules/home/common.nix
    ../../modules/home/niri.nix
    ../../modules/home/noctalia.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = user.name;
    homeDirectory = user.homeDir;
    stateVersion = "24.11";
  };

  home.sessionPath = [
    "${user.homeDir}/.nix-profile/bin"
    "/etc/profiles/per-user/${user.name}/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
  ];
}

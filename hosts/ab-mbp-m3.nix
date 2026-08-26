{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../modules/darwin
    ../roles/darwin-desktop.nix
    ../roles/workstation.nix
  ];

  home-manager.users.${config.mine.user.name}.imports = [
    ../profiles/home/default.nix
    ../profiles/home/darwin-desktop.nix
  ];

  networking.hostName = "ab-mbp-m3";
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    primaryUser = config.mine.user.name;
    stateVersion = 5;
  };

  mine.user = {
    enable = true;
    name = "ab";
    alias = "Alexander Büscher";
    email = "alexanderbuescher@outlook.com";
    homeDir = "/Users/ab";
    shell.package = pkgs.zsh;
  };
}

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
    ../profiles/home/darwin-workstation.nix
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
    homeDir = "/Users/ab";
    shell.package = pkgs.zsh;
  };
}

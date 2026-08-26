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

  home-manager.users.${config.mine.user.name} = {
    imports = [
      ../profiles/home/default.nix
    ];
    manual.manpages.enable = false;
  };

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

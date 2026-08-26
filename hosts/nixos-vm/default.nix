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
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/shared
    ../../modules/nixos/apps/codex.nix
    ../../modules/nixos/apps/firefox.nix
    ../../modules/nixos/apps/ghostty.nix
    ../../modules/nixos/apps/wezterm.nix
    ../../modules/nixos/dbus.nix
    ../../modules/nixos/greetd.nix
    ../../modules/nixos/keyring.nix
    ../../modules/nixos/networkmanager.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/openssh.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/polkit.nix
    ../../modules/nixos/portal.nix
    ../../modules/nixos/session.nix
    ../../modules/nixos/zsh.nix
  ];

  home-manager.users.${config.mine.user.name}.imports = [
    ../../homes/linux-desktop.nix
  ];

  system.stateVersion = "24.11";
  time.timeZone = "Europe/Copenhagen";

  virtualisation.vmware.guest.enable = true;

  networking.hostName = "nixos-vm";
  nixpkgs.hostPlatform = "aarch64-linux";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  mine = {
    apps = {
      codex = enabled;
      firefox = enabled;
      ghostty = enabled;
      wezterm = enabled;
    };

    desktop = {
      greetd = enabled;
      niri = enabled;
      portal = enabled;
      session = enabled;
    };

    system = {
      fonts = enabled;
      nix = enabled;
      networking.networkmanager = enabled;
      services = {
        dbus = enabled;
        keyring = enabled;
        openssh = enabled;
        polkit = enabled;
      };
      sound.pipewire = enabled;
    };

    user = {
      enable = true;
      name = "alex";
      alias = "Alexander Büscher";
      email = "alexanderbuescher@outlook.com";
      homeDir = "/home/alex";
      home-manager = enabled;
      shell.package = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}

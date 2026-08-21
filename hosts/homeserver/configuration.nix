{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib.alex) enabled;
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.apple-t2
    ./hardware-configuration.nix
    ../../modules/nixos/import.nix
    ../../modules/shared/import.nix
    ../../modules/home/import.nix
  ];

  config = {
    system.stateVersion = "25.05";
    time.timeZone = "Europe/Copenhagen";

    networking = {
      hostName = "homeserver";
      firewall.enable = true;
    };

    nixpkgs.hostPlatform = "x86_64-linux";

    hardware.apple-t2.firmware.enable = true;

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    services.openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    environment.systemPackages = with pkgs; [
      neovim
      restic
    ];

    mine = {
      user = {
        enable = true;
        name = "ab";
        homeDir = "/home/ab";
        home-manager.enable = true;
        shell.package = pkgs.zsh;
        extraGroups = [
          "wheel"
          "docker"
        ];
      };

      cli-tools.git = enabled;

      server = {
        backups.restic = enabled;
        docker = enabled;
        mounts.backup = enabled;
        tailscale = enabled;
        apps = {
          bookorbit = enabled;
          homebox = enabled;
        };
      };

      system = {
        nix = enabled;
        utils = enabled;
      };
    };
  };
}

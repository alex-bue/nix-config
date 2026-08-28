{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  flake.modules.nixos.nixos-vm = {
    imports = [
      nixos.nixos-vm-hardware
      nixos.alexander
      nixos.home-manager
      nixos.nix
      nixos.fonts
      nixos.shell
      nixos.openssh
      nixos.niri-desktop
    ];
    home-manager.users.alex = {
      imports = [
        homeManager.alexander
        homeManager.niri-desktop
      ];
      home.username = "alex";
      home.homeDirectory = "/home/alex";
    };
    system.stateVersion = "24.11";
    time.timeZone = "Europe/Copenhagen";
    virtualisation.vmware.guest.enable = true;
    networking.hostName = "nixos-vm";
    nixpkgs.hostPlatform = "aarch64-linux";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };

  flake.nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [ nixos.nixos-vm ];
  };
}

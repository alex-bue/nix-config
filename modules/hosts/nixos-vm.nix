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
      nixos.dbus
      nixos.greetd
      nixos.keyring
      nixos.networkmanager
      nixos.niri
      nixos.pipewire
      nixos.polkit
      nixos.portal
      nixos.session
      nixos.firefox
      nixos.ghostty
      nixos.wezterm
    ];
    home-manager.users.alex = {
      imports = [
        homeManager.alexander
        homeManager.core-cli
        homeManager.neovim
        homeManager.git
        homeManager.shell
        homeManager.fzf
        homeManager.starship
        homeManager.zoxide
        homeManager.nh
        homeManager.yazi
        homeManager.tmux
        homeManager.coding-agents
        homeManager.repository-tools
        homeManager.ghostty
        homeManager.niri
        homeManager.noctalia
        homeManager.wezterm
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

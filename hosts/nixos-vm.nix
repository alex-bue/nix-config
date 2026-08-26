{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./nixos-vm/hardware-configuration.nix
    ../modules/nixos
    ../roles/linux-desktop.nix
    ../roles/workstation.nix
  ];

  home-manager.users.${config.mine.user.name}.imports = [
    ../profiles/home/linux-desktop.nix
  ];

  system.stateVersion = "24.11";
  time.timeZone = "Europe/Copenhagen";

  virtualisation.vmware.guest.enable = true;

  environment.systemPackages = [
    pkgs.neovim
  ];

  networking.hostName = "nixos-vm";
  nixpkgs.hostPlatform = "aarch64-linux";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  mine.user = {
    enable = true;
    name = "alex";
    homeDir = "/home/alex";
    shell.package = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}

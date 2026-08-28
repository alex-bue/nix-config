{
  flake.modules.nixos.nixos-vm-hardware = { lib, ... }: {
    boot.initrd.availableKernelModules = [
      "ehci_pci"
      "ahci"
      "xhci_pci"
      "nvme"
      "usbhid"
      "sr_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/deb5fd26-6b16-4f51-9e4f-3375b5beb4d0";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3770-6A99";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    swapDevices = [
      { device = "/dev/disk/by-uuid/4f48a788-9c27-4d3d-86e8-3a3b24089b06"; }
    ];
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}

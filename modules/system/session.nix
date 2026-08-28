{
  flake.modules.nixos.session = { pkgs, ... }: {
    programs.dconf.enable = true;
    environment.systemPackages = [ pkgs.networkmanagerapplet ];
  };
}

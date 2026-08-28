{
  flake.modules.nixos.portal = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      xdg-utils
    ];
  };
}

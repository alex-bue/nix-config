{ config, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  flake.modules.nixos.niri-desktop = {
    imports = [
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
  };
  flake.modules.homeManager.niri-desktop = {
    imports = [
      homeManager.development
      homeManager.ghostty
      homeManager.niri
      homeManager.noctalia
      homeManager.wezterm
    ];
  };
}

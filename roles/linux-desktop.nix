{ lib, ... }:
let
  inherit (lib.alex) enabled;
in
{
  imports = [
    ../modules/nixos/apps/codex.nix
    ../modules/nixos/apps/firefox.nix
    ../modules/nixos/apps/ghostty.nix
    ../modules/nixos/apps/wezterm.nix
    ../modules/nixos/dbus.nix
    ../modules/nixos/greetd.nix
    ../modules/nixos/keyring.nix
    ../modules/nixos/networkmanager.nix
    ../modules/nixos/niri.nix
    ../modules/nixos/nix.nix
    ../modules/nixos/openssh.nix
    ../modules/nixos/pipewire.nix
    ../modules/nixos/polkit.nix
    ../modules/nixos/portal.nix
    ../modules/nixos/session.nix
    ../modules/nixos/zsh.nix
  ];

  mine = {
    apps = {
      codex = enabled;
      firefox = enabled;
      ghostty = enabled;
      wezterm = enabled;
    };
    cli-tools.git = enabled;
    desktop = {
      greetd = enabled;
      niri = enabled;
      portal = enabled;
      session = enabled;
    };
    system = {
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
  };
}

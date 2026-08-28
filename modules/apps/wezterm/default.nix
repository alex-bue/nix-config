{ ... }:
{
  flake.modules.darwin.wezterm = {
    homebrew.casks = [ "wezterm" ];
  };
  flake.modules.nixos.wezterm = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.wezterm ];
  };
  flake.modules.homeManager.wezterm = {
    xdg.configFile = {
      "wezterm/wezterm.lua".source = ./wezterm.lua;
      "wezterm/appearance.lua".source = ./appearance.lua;
      "wezterm/fonts.lua".source = ./fonts.lua;
      "wezterm/keybinds.lua".source = ./keybinds.lua;
    };
  };
}

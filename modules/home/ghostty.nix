{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = null;
    installBatSyntax = false;
    systemd.enable = false;
    settings = {
      font-size = if pkgs.stdenv.isDarwin then 14 else 12;
      font-family = "JetBrainsMono Nerd Font";
      window-decoration = "auto";
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 1;
      background-blur-radius = 32;
      cursor-style = "block";
      cursor-style-blink = true;
      scrollback-limit = 50000;
      mouse-hide-while-typing = true;
      copy-on-select = true;
      confirm-close-surface = false;
      app-notifications = "no-clipboard-copy";
      keybind = [
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
      ];
      gtk-titlebar = false;
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,no-cursor";
      theme = "Everforest Dark Hard";
    };
  };
}

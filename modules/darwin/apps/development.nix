{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "dbeaver-community"
    "docker-desktop"
    "ghostty"
    "visual-studio-code"
    "wezterm"
  ];
}

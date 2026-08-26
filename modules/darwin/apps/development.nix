{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "codex"
    "dbeaver-community"
    "docker-desktop"
    "ghostty"
    "visual-studio-code"
    "wezterm"
  ];
}

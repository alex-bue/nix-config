{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "iina"
    "spotify"
    "steam"
    "subsurface"
  ];
}

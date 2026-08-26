{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "nikitabobko/tap/aerospace"
    "betterdisplay"
    "karabiner-elements"
    "logi-options+"
    "scroll-reverser"
  ];
}

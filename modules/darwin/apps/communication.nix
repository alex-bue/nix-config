{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "anydesk"
    "discord"
  ];
}

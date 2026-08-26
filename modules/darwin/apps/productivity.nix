{ lib, ... }:
{
  homebrew.casks = lib.mkAfter [
    "alfred"
    "anki"
    "bitwarden"
    "calibre"
    "firefox"
    "google-chrome"
    "obsidian"
    "raycast"
    "skim"
    "zotero"
  ];
}

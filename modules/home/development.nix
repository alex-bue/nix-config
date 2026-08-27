{ pkgs, ... }:
{
  home.packages = with pkgs; [
    codex
    just
    lazygit
    opencode
    statix
  ];
}

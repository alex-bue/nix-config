{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    lazygit
    statix
  ];
}

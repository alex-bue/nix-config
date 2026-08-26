{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
    just
    lazygit
  ];
}

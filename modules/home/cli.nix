{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    neovim
    yazi
  ];
}

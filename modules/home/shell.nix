{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sesh
    starship
    tmux
    zoxide
    zsh-powerlevel10k
  ];
}

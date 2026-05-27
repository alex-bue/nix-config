{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.home-manager.shared;
  user = config.mine.user;
in
{
  options.mine.home-manager.shared.enable = lib.mkEnableOption "shared home-manager settings";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        bash-completion
        starship
        tmux
        sesh
        zoxide
        zsh-powerlevel10k
        chezmoi
        neovim
        yazi
        bitwarden-cli
        docker
        docker-compose
        gh
        just
        lazygit
        nixfmt
        statix
        tree-sitter
        cargo
        go
        nodejs_24
        openjdk
        pipx
        python3
        php
        rustc
        gcc
        ffmpeg
        ghostscript
        graphviz
        imagemagick
        poppler
        tex-fmt
        texliveFull
      ];
    };
  };
}

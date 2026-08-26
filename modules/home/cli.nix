{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    curl
    eza
    fd
    neovim
    ripgrep
    unzip
  ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nix-config";

    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}

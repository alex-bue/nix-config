{ pkgs, ... }:
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

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}

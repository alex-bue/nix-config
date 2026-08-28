{
  flake.modules.homeManager.core-cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      chezmoi
      curl
      eza
      fd
      ripgrep
      unzip
    ];
  };
}

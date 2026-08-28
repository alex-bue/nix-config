{
  flake.modules.homeManager.repository-tools = { pkgs, ... }: {
    home.packages = with pkgs; [
      just
      lazygit
      statix
    ];
  };
}

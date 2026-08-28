{
  flake.modules.homeManager.neovim = { pkgs, ... }: {
    home.packages = [ pkgs.neovim ];
  };
}

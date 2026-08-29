{
  flake.modules.homeManager.python = { pkgs, ... }: {
    home.packages = [ pkgs.uv ];
  };
}

{
  flake.modules.homeManager.herdr = { pkgs, ... }: {
    home.packages = [ pkgs.herdr ];
    xdg.configFile."herdr/config.toml".source = ./config.toml;
  };
}

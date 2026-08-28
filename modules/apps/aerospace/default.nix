{ ... }:
{
  flake.modules.darwin.aerospace = {
    homebrew.casks = [ "nikitabobko/tap/aerospace" ];
  };
  flake.modules.homeManager.aerospace = {
    xdg.configFile."aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}

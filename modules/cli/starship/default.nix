{
  flake.modules.homeManager.starship = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };
}

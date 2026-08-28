{
  flake.modules.homeManager.nh = { config, ... }: {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/nix-config";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}

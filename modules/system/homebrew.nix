{ inputs, ... }:
{
  flake.modules.darwin.homebrew = { config, ... }: {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "none";
      };
    };
    nix-homebrew = {
      enable = true;
      autoMigrate = true;
      mutableTaps = true;
      trust = {
        formulae = [ ];
        casks = [ ];
        commands = [ ];
        taps = [ "nikitabobko/tap" ];
      };
      user = config.system.primaryUser;
    };
  };
}

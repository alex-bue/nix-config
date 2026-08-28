{ inputs, ... }:
{
  flake.modules.darwin.nix = {
    imports = [ inputs.determinate.darwinModules.default ];
    determinateNix = {
      enable = true;
      determinateNixd.builder.state = "enabled";
      customSettings = {
        experimental-features = "nix-command flakes";
        extra-experimental-features = "parallel-eval";
        warn-dirty = false;
      };
    };
    system.checks.verifyNixPath = false;
  };
  flake.modules.nixos.nix = {
    nix = {
      enable = true;
      settings = {
        experimental-features = "nix-command flakes";
        warn-dirty = false;
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
}

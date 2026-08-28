{ ... }:
{
  flake.modules.darwin.firefox = {
    homebrew.casks = [ "firefox" ];
  };
  flake.modules.nixos.firefox = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.firefox ];
  };
}

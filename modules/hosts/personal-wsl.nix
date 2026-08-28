{ config, inputs, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.personal-wsl = {
    imports = [
      homeManager.alexander
      homeManager.core-cli
      homeManager.neovim
      homeManager.git
      homeManager.shell
      homeManager.fzf
      homeManager.starship
      homeManager.zoxide
      homeManager.nh
      homeManager.yazi
      homeManager.tmux
      homeManager.coding-agents
      homeManager.repository-tools
    ];
    home.username = "ab";
    home.homeDirectory = "/home/ab";
  };

  flake.homeConfigurations."ab@personal-wsl" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    modules = [ homeManager.personal-wsl ];
  };
}

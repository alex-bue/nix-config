{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.base = {
    imports = [
      homeManager.core-cli
      homeManager.neovim
      homeManager.git
      homeManager.shell
      homeManager.direnv
      homeManager.fzf
      homeManager.starship
      homeManager.zoxide
      homeManager.nh
      homeManager.yazi
      homeManager.tmux
      homeManager.coding-agents
      homeManager.repository-tools
      homeManager.python
    ];
  };
}

{ config, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.modules.darwin.development = {
    imports = [
      darwin.dbeaver
      darwin.docker-desktop
      darwin.vscode
    ];
  };
  flake.modules.homeManager.development = {
    imports = [
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
    manual.manpages.enable = false;
  };
}

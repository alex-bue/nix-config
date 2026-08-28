{
  flake.modules.homeManager.coding-agents = { pkgs, ... }: {
    home.packages = with pkgs; [
      codex
      opencode
    ];
  };
}

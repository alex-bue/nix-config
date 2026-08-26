{ user, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = user.name;
    homeDirectory = user.homeDir;
    stateVersion = "24.11";
  };
}

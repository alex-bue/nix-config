{
  flake.modules.darwin.alexander = { pkgs, ... }: {
    users.knownUsers = [ "ab" ];
    users.users.ab = {
      name = "ab";
      home = "/Users/ab";
      isHidden = false;
      shell = pkgs.zsh;
      uid = 501;
    };
    system.primaryUser = "ab";
  };

  flake.modules.nixos.alexander = { pkgs, ... }: {
    users.groups.alex = { };
    users.users.alex = {
      isNormalUser = true;
      createHome = true;
      group = "alex";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
    nix.settings.trusted-users = [ "alex" ];
  };

  flake.modules.homeManager.alexander = {
    programs.home-manager.enable = true;
    programs.git.settings.user = {
      name = "Alexander Büscher";
      email = "alexanderbuescher@outlook.com";
    };
    home.stateVersion = "24.11";
    xdg.enable = true;
  };
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (config.mine) user;
in
{
  options.mine.user = {
    enable = mkEnableOption "Enable user";
    name = mkOption {
      type = types.str;
      default = "ab";
      description = "User account name";
    };
    alias = mkOption {
      type = types.str;
      default = "ab";
      description = "Full alias";
    };
    email = mkOption {
      type = types.str;
      default = "";
      description = "User email";
    };
    homeDir = mkOption {
      type = types.str;
      default = "/Users/${user.name}";
      description = "Home directory path";
    };
    home-manager.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable home-manager for this user";
    };
    shell.package = mkOption {
      type = types.package;
      default = pkgs.zsh;
      description = "User shell package";
    };
  };

  config = mkIf user.enable {
    users.knownUsers = [ user.name ];

    users.users.${user.name} = {
      name = user.name;
      home = user.homeDir;
      isHidden = false;
      shell = user.shell.package;
      uid = 501;
    };
  };
}

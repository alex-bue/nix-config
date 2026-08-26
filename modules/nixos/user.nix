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
      default = "alex";
      description = "User account name";
    };
    alias = mkOption {
      type = types.str;
      default = "alex";
      description = "Full alias";
    };
    email = mkOption {
      type = types.str;
      default = "";
      description = "User email";
    };
    homeDir = mkOption {
      type = types.str;
      default = "/home/${user.name}";
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
    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [ "wheel" ];
      description = "Supplementary groups for the user";
    };
  };

  config = mkIf user.enable {
    users.groups.${user.name} = { };

    users.users.${user.name} = {
      isNormalUser = true;
      createHome = true;
      group = user.name;
      extraGroups = user.extraGroups;
      shell = user.shell.package;
    };

    mine.system.shell.zsh.enable = mkIf (user.shell.package == pkgs.zsh) true;

    nix.settings.trusted-users = [ user.name ];
  };
}

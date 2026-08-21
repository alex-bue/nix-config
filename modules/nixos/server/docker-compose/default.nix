{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    escapeShellArg
    mapAttrs'
    mkEnableOption
    mkIf
    mkOption
    nameValuePair
    optional
    types
    ;

  cfg = config.mine.server.composeStacks;

  dockerCompose = "${pkgs.docker-compose}/bin/docker-compose";
  mkdir = "${pkgs.coreutils}/bin/mkdir";
  ln = "${pkgs.coreutils}/bin/ln";

  composeStackOptions =
    { name, ... }:
    {
      options = {
        enable = mkEnableOption "Docker Compose stack";

        composeFile = mkOption {
          type = types.path;
          description = "Main Docker Compose file for this stack.";
        };

        overrideComposeFile = mkOption {
          type = types.nullOr types.path;
          default = null;
          description = "Optional Docker Compose override file for this stack.";
        };

        envFile = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Optional runtime env file path outside the Nix store.";
        };

        workingDirectory = mkOption {
          type = types.str;
          default = "/srv/docker/${name}";
          description = "Runtime directory for relative Compose paths and app state.";
        };
      };
    };

  enabledStacks = lib.filterAttrs (_: stack: stack.enable) cfg;

  mkComposeFlags =
    stack:
    concatStringsSep " " (
      [
        "--project-directory"
        (escapeShellArg stack.workingDirectory)
        "-f"
        (escapeShellArg "${stack.workingDirectory}/compose.yml")
      ]
      ++ optional (stack.overrideComposeFile != null) "-f"
      ++ optional (stack.overrideComposeFile != null) (
        escapeShellArg "${stack.workingDirectory}/compose.override.yml"
      )
      ++ optional (stack.envFile != null) "--env-file"
      ++ optional (stack.envFile != null) (escapeShellArg stack.envFile)
    );

  mkLinkCommands =
    stack:
    concatStringsSep "\n" (
      [
        "${mkdir} -p ${escapeShellArg stack.workingDirectory}"
        "${ln} -sfn ${escapeShellArg stack.composeFile} ${escapeShellArg "${stack.workingDirectory}/compose.yml"}"
      ]
      ++
        optional (stack.overrideComposeFile != null)
          "${ln} -sfn ${escapeShellArg stack.overrideComposeFile} ${escapeShellArg "${stack.workingDirectory}/compose.override.yml"}"
    );

  mkRestartTriggers =
    stack:
    [ stack.composeFile ] ++ optional (stack.overrideComposeFile != null) stack.overrideComposeFile;
in
{
  options.mine.server.composeStacks = mkOption {
    type = types.attrsOf (types.submodule composeStackOptions);
    default = { };
    description = "Docker Compose stacks managed by systemd.";
  };

  config = mkIf (enabledStacks != { }) {
    virtualisation.docker.enable = true;

    systemd.services = mapAttrs' (
      name: stack:
      let
        serviceName = "docker-compose-${name}";
        composeFlags = mkComposeFlags stack;
      in
      nameValuePair serviceName {
        description = "Docker Compose stack ${name}";
        wantedBy = [ "multi-user.target" ];
        after = [
          "docker.service"
          "docker.socket"
          "network-online.target"
        ];
        requires = [
          "docker.service"
          "network-online.target"
        ];
        restartTriggers = mkRestartTriggers stack;

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          TimeoutStartSec = 0;
          TimeoutStopSec = 120;
          WorkingDirectory = stack.workingDirectory;
        };

        script = ''
          set -euo pipefail
          ${mkLinkCommands stack}
          ${dockerCompose} ${composeFlags} up -d --remove-orphans
        '';

        preStop = ''
          ${dockerCompose} ${composeFlags} down
        '';
      }
    ) enabledStacks;
  };
}

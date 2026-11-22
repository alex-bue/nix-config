{
  flake.modules.homeManager.herdr =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = [ pkgs.herdr ];

      # Keep the file writable for Herdr's Settings UI.
      home.activation.mergeHerdrConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] (
        lib.hm.generators.mkImpureConfigMerger {
          inherit pkgs;
          format = "toml";
          empty = "{}";
          jqOperation = "$dynamic * $static";
          path = "${config.xdg.configHome}/herdr/config.toml";
          staticSettings = (pkgs.formats.toml { }).generate "herdr-settings.toml" {
            keys = {
              prefix = "ctrl+space";
              navigate_workspace_up = "k";
              navigate_workspace_down = "j";
            };
          };
        }
      );
    };
}

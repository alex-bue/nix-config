{ inputs, ... }:
{
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;
      checks.formatting =
        pkgs.runCommand "check-nix-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; }
          ''
            cp -r ${../..} source
            chmod -R +w source
            find source -name '*.nix' -print0 | xargs -0 nixfmt --check
            touch $out
          '';
    };
}

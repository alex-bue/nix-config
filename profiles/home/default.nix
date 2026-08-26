{
  imports = [
    ./base.nix
    ../../modules/home/cli.nix
    ../../modules/home/development.nix
    ../../modules/home/shell.nix
  ];

  # Work around NixOS/nixpkgs#485682 in the generated options manpage.
  manual.manpages.enable = false;
}

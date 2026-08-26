# Home Manager activation

Each user and target has one activation owner. This avoids two Home Manager
generations competing to manage the same files.

| Target | Activation owner | Profile |
| --- | --- | --- |
| `ab@ab-mbp-m3` | `darwin-rebuild` | `darwin-workstation.nix` |
| `alex@nixos-vm` | `nixos-rebuild` | `linux-desktop.nix` |
| `ab@standalone-darwin` | standalone Home Manager | `darwin-workstation.nix` |
| `alex@standalone-linux` | standalone Home Manager | `linux-desktop.nix` |

The first two rows are embedded in their system configurations and are not
exported as standalone flake outputs. Activate them only through the owning
system rebuild command. The `standalone-*` outputs are for machines whose
system configuration is not managed by this flake.

Build or activate a standalone profile with:

```sh
just home-build 'ab@standalone-darwin'
just home-switch 'ab@standalone-darwin'

just home-build 'alex@standalone-linux'
just home-switch 'alex@standalone-linux'
```

The profiles do not add NixOS or nix-darwin system paths to `PATH`. Home
Manager initializes its own profile, while the host operating system remains
responsible for system paths.

For a machine that needs a smaller configuration, add a new profile under
`profiles/home/` and import only the capabilities it needs. Reusable
capabilities are exported through `homeModules` and can also be imported by
flakes outside this repository.

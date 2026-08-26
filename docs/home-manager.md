# Home Manager activation

Each user and target has one activation owner. This avoids two Home Manager
generations competing to manage the same files.

| Target | Activation owner | Profile |
| --- | --- | --- |
| `ab@ab-mbp-m3` | `darwin-rebuild` | `default.nix` + Darwin setting |
| `alex@nixos-vm` | `nixos-rebuild` | `default.nix` + desktop modules |
| `ab@personal-wsl` | standalone Home Manager | `default.nix` |

The first two rows are embedded in their system configurations and are not
exported as standalone flake outputs. Activate them only through the owning
system rebuild command. The WSL target runs Ubuntu rather than NixOS, so
standalone Home Manager owns its user environment.

Build or activate the personal WSL target with:

```sh
just home-build 'ab@personal-wsl'
just home-switch 'ab@personal-wsl'
```

This target assumes an `ab` account at `/home/ab` on `x86_64-linux`.
Create another concrete `homeConfigurations` entry when a machine has a
different user, home directory, architecture, or profile composition.

The profiles do not add NixOS or nix-darwin system paths to `PATH`. Home
Manager initializes its own profile, while the host operating system remains
responsible for system paths.

For a machine that needs a smaller configuration, add a new profile under
`profiles/home/` and import only the capabilities it needs. Reusable
capabilities are exported through `homeModules` and can also be imported by
flakes outside this repository.

`default.nix` describes the reusable personal environment. The NixOS host adds
Niri and Noctalia through its integrated Home Manager imports. Ordinary WSL
has no system role and imports only the Home Manager profile. Add profiles such
as `work.nix` or `server.nix` only when their module composition actually
differs from `default.nix`.

## On-demand tools

The default profile installs only persistent shell, editor, and repository
workflow tools. Language toolchains, container clients, document processors,
and media utilities should normally come from a project's development shell:

```sh
nix develop
```

For temporary use outside a project, open a disposable shell containing the
needed packages:

```sh
nix shell nixpkgs#go nixpkgs#nodejs_24
nix shell nixpkgs#imagemagick nixpkgs#ffmpeg
nix shell nixpkgs#statix
nix shell nixpkgs#texliveFull
```

Use `nix fmt` for this repository; the flake supplies its pinned formatter.

Import `homeModules.shell`, `homeModules.cli`, or `homeModules.development`
when another flake needs one of the reusable persistent capabilities.

# Nix configuration

This flake manages the `ab-mbp-m3` macOS host, the `nixos-vm` NixOS host,
and the standalone `ab@personal-wsl` Home Manager configuration.

## Architecture

The repository uses a dendritic, aspect-oriented architecture. Every Nix file
under `modules/` is a flake-parts module discovered recursively by
`import-tree`. Files publish typed facets through
`flake.modules.{darwin,nixos,homeManager}`; directory placement is only for
human navigation.

Concepts own their configuration across platforms. For example,
`modules/apps/wezterm/default.nix` owns the Homebrew installation, NixOS
package, Home Manager files, and colocated Lua configuration. The `base` and
`gui` Home Manager environments compose user-facing facets, while host modules
compose system facets alongside identity, hardware, and state versions.

```text
modules/
├── apps/          cross-platform and desktop applications
├── cli/           terminal programs and configuration
├── development/   persistent development tools
├── desktop/       compositors and desktop integration
├── networking/    networking facilities
├── services/      system services
├── system/        platform infrastructure and defaults
├── hardware/      typed hardware facets
├── users/         user accounts and identity
├── base.nix        shared terminal Home Manager composition
├── gui.nix         shared graphical Home Manager composition
├── hosts/         system compositions and concrete outputs
└── flake/         flake-parts infrastructure and repository tooling
```

Adding a `.nix` file below `modules/` automatically evaluates it as a
flake-parts module. It must not be a raw NixOS, nix-darwin, or Home Manager
module. Publish raw typed modules through `flake.modules` and import those
facets from concrete hosts.

## Composition

- `base` composes the shared terminal, editor, and repository environment.
- `gui` extends `base` with the cross-platform Ghostty and WezTerm facets.
- Graphical hosts add their platform desktop facets directly: AeroSpace on
  Darwin, or Niri and Noctalia on Linux.
- `ab-mbp-m3` and `nixos-vm` use `gui`; `personal-wsl` uses `base`.
- System applications, services, hardware, and platform settings remain
  explicitly composed by their concrete host.

These environments are plain typed Home Manager modules, not a general role or
profile framework.

## Commands

The `justfile` remains the command-line entry point:

```sh
just
just build
just build nixos-vm
just build 'ab@personal-wsl'
just switch
just check
just fmt
just update
just update-one nixpkgs
just upgrade
just gc
```

`build` never activates a configuration. `switch` and `upgrade` do activate
one and should only be run intentionally on the managed target.

## Adding configuration

1. Add or extend the owning concept under `modules/`.
2. Publish each implementation under its real module class.
3. Import Home Manager facets from `base` or `gui`; import system facets from
   each concrete host that consumes them.
4. Keep non-Nix assets beside the owning aspect.
5. Run `just fmt`, `just check`, and build every affected output.

Do not add filesystem import registries, platform package dumps, feature-enable
flags, or global `specialArgs` merely to connect aspects.

See [Home Manager activation](docs/home-manager.md) for activation ownership.

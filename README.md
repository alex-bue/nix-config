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
package, Home Manager files, and colocated Lua configuration. Host modules
compose the required facets directly alongside identity, hardware, and state
versions.

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
├── hosts/         direct aspect compositions and concrete outputs
└── flake/         flake-parts infrastructure and repository tooling
```

Adding a `.nix` file below `modules/` automatically evaluates it as a
flake-parts module. It must not be a raw NixOS, nix-darwin, or Home Manager
module. Publish raw typed modules through `flake.modules` and import those
facets from concrete hosts.

## Composition

- `ab-mbp-m3` directly imports the Darwin applications, system facilities, and
  Home Manager facets used by the Mac.
- `nixos-vm` directly imports its hardware, services, Niri desktop, applications,
  and Home Manager facets.
- `personal-wsl` directly imports the shared terminal and development facets.

There is deliberately no role or profile layer. Repeated import lists keep each
concrete output explicit and avoid single-consumer composition abstractions.

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
3. Import the facet directly from every concrete host that consumes it.
4. Keep non-Nix assets beside the owning aspect.
5. Run `just fmt`, `just check`, and build every affected output.

Do not add filesystem import registries, platform package dumps, feature-enable
flags, or global `specialArgs` merely to connect aspects.

See [Home Manager activation](docs/home-manager.md) for activation ownership.

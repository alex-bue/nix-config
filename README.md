# Nix configuration

This flake manages the `ab-mbp-m3` macOS host, the `nixos-vm` NixOS host,
and the standalone `ab@personal-wsl` Home Manager configuration.

## Layout

```text
flake.nix                 Flake inputs and exported configurations
hosts/<host>/             Complete macOS or NixOS host configurations
homes/                    Complete Home Manager environments
modules/darwin/           Reusable nix-darwin modules
modules/nixos/            Reusable NixOS modules
modules/home/             Reusable Home Manager modules
modules/shared/           Modules shared by system platforms
lib/                      Small repository helpers
docs/                     Supporting documentation
```

Hosts and home environments explicitly import the modules they use. Adding a
file under `modules/` does not enable it automatically.

## Commands

The [`justfile`](justfile) is the command-line entry point. Its `build` and
`switch` recipes use `nh` and select the appropriate backend for macOS, NixOS,
or standalone Home Manager based on the current system.

```sh
just                  # list available recipes
just build            # build the current host
just switch           # build and activate the current host
just check            # evaluate all flake checks
just fmt              # format Nix and just files
just update           # update every flake input
just update-one nixpkgs
just upgrade          # update, check, and switch
just gc               # keep five generations and at least seven days
```

Pass a target when it cannot be inferred or when selecting another
configuration for the current platform:

```sh
just build nixos-vm             # on NixOS
just switch 'ab@personal-wsl'   # on non-NixOS Linux
```

On non-NixOS Linux, `build` and `switch` require a Home Manager target argument
or `NH_HOME_CONFIG`.

## Adding a host

1. Create `hosts/<hostname>/default.nix`, keeping hardware, disk, and networking
   files beside it.
2. Explicitly import the required platform and feature modules.
3. Select one complete environment from `homes/` for Home Manager.
4. Export the host from `darwinConfigurations` or `nixosConfigurations` in
   `flake.nix`.
5. Run `just fmt`, `just check`, and `just build <hostname>`.

Keep composition in the concrete host until multiple hosts genuinely share the
same system decisions.

## Adding a standalone home

1. Reuse a complete environment in `homes/`, or add a new one.
2. Add a `homeConfigurations."user@target"` entry in `flake.nix` with its
   system, user details, and environment module.
3. Run `just fmt`, `just check`, and `just build 'user@target'` on a non-NixOS
   Linux system.

See [Home Manager activation](docs/home-manager.md) for activation ownership
and the boundary with chezmoi.

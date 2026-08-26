# Nix configuration

This flake manages concrete macOS and NixOS machines plus standalone Home
Manager environments for systems such as Ubuntu WSL.

## Structure

```text
flake output
  -> hosts/<machine>/default.nix
       -> modules/{darwin,nixos,shared}/
       -> homes/<environment>.nix
            -> modules/home/
```

- `hosts/` contains complete system configurations. A host explicitly imports
  and enables every system capability it needs.
- `homes/` contains complete user environments. The same environment can be
  embedded in a system host or used by standalone Home Manager.
- `modules/` contains reusable feature implementations. A module is inactive
  until a host or home environment explicitly imports it.

## Common commands

```sh
just check
just build
just switch
just build-vm
just home-build 'ab@personal-wsl'
just home-switch 'ab@personal-wsl'
```

## Add a system machine

1. Create `hosts/<hostname>/default.nix` and keep hardware, disk, or networking
   files beside it.
2. Explicitly import the required platform and feature modules in that host.
3. Select one complete Home Manager environment from `homes/`.
4. Add the host to `nixosConfigurations` or `darwinConfigurations` in
   `flake.nix`.
5. Run `nix flake check` and build the new host output.

Keep composition in the host until multiple machines genuinely share a
substantial set of system decisions. Extract shared composition only when that
duplication exists.

## Add a standalone home

1. Reuse an environment such as `homes/personal.nix`, or add a new complete
   environment such as `homes/work.nix`.
2. Add a `homeConfigurations."user@target"` entry in `flake.nix` with the
   target system, username, and home directory.
3. Activate it with `just home-switch 'user@target'`.

See [Home Manager activation](docs/home-manager.md) for activation ownership
and the boundary with chezmoi.

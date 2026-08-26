# Repository Guidelines

## Project Structure & Module Organization

This repository is a Nix flake for macOS and NixOS host configuration.

- `flake.nix` defines inputs and exposes system and standalone Home Manager configurations.
- `hosts/<host>/default.nix` is the complete system configuration for one concrete machine. It explicitly selects system modules and Home Manager environment.
- `homes/` contains complete user environments that compose reusable Home Manager capabilities. These environments also support standalone Home Manager targets.
- `modules/darwin/`, `modules/nixos/`, `modules/home/`, and `modules/shared/` contain explicitly imported reusable modules.
- `lib/default.nix` contains small shared helpers, currently `lib.alex.enabled` and `lib.alex.disabled`.
- `flake.lock` pins dependency revisions; update it intentionally.

## Build, Test, and Development Commands

- `nix flake check` evaluates the flake and catches common module or syntax errors.
- `nix build .#darwinConfigurations.ab-mbp-m3.system` builds the macOS system derivation without switching.
- `nix build .#nixosConfigurations.nixos-vm.config.system.build.toplevel` builds the NixOS VM system closure.
- `darwin-rebuild switch --flake .#ab-mbp-m3` applies the macOS configuration on the target machine.
- `sudo nixos-rebuild switch --flake .#nixos-vm` applies the NixOS configuration on the target machine.
- `nix flake update` updates pinned inputs in `flake.lock`; review resulting changes before committing.

## Coding Style & Naming Conventions

- Format Nix with `nixfmt` if available; keep two-space indentation and the existing brace layout.
- Prefer shallow feature modules such as `docker.nix`; use per-host directories because machine configurations commonly include hardware, disk, or networking files.
- Keep imports explicit. A file must not become active merely because it exists.
- Define feature switches as `options.mine.<area>.<name>.enable = lib.mkEnableOption "...";`.
- Gate module config with `config = lib.mkIf cfg.enable { ... };`.
- Make system feature decisions in concrete host files. Extract shared composition only after multiple hosts genuinely reuse it.
- Import one complete `homes/*.nix` environment from each host or standalone Home Manager output; importing a Home Manager feature module enables that capability.

## Testing Guidelines

There is no separate test suite. Treat evaluation and builds as the validation path:

- Run `nix flake check` for every change.
- Build the affected host output before switching when changing shared or platform modules.
- For new modules, verify the option path is enabled from a host file and that the generated system includes the expected package, cask, service, or Home Manager setting.

## Commit & Pull Request Guidelines

- Match the existing concise commit style, usually imperative lowercase, for example `add log options to darwin`.
- Conventional prefixes such as `feat:` and `refactor:` are present but not required; use them when they clarify scope.
- Pull requests should describe the affected host or module path, list validation commands run, and mention any `flake.lock` updates.
- Keep unrelated formatting, package updates, and behavior changes in separate commits.

# Repository instructions

Scope: whole repository.

## Operating rules

- Commit completed changes locally. Do not push, deploy, switch configurations,
  or otherwise change managed hosts live unless explicitly asked.
- Keep commits task-focused and separate distinct logical changes. Preserve
  unrelated worktree changes.
- Never modify, restore, reformat, stage, or commit changes you did not produce.
  Dirty files may belong to the user or another agent.
- Prefer simple declarative Nix changes over ad hoc scripts or imperative setup.
- Use the `justfile` recipes for repository workflows. Check command help when
  behavior or flags are uncertain.
- Use packages already available from nixpkgs before adding local package
  definitions or vendored sources.
- Treat in-tree modules and options as internal. Update all in-repository call
  sites when changing them; do not retain compatibility aliases solely for
  unknown out-of-tree consumers.
- Remove unused features together with their in-tree wiring. Git history is the
  fallback for code needed later.
- Keep `flake.lock` changes intentional and review them separately from
  unrelated behavior changes.

## Repository layout

- `flake.nix` defines inputs and exports system and standalone Home Manager
  configurations.
- `hosts/<host>/` contains one complete machine configuration, including
  host-specific hardware, disk, or networking files.
- `homes/` contains complete Home Manager environments used by hosts or
  standalone Home Manager targets.
- `modules/darwin/`, `modules/nixos/`, `modules/home/`, and `modules/shared/`
  contain explicitly imported reusable modules.
- `lib/default.nix` contains small shared helpers.
- `docs/` contains supporting documentation.

Keep imports explicit: a module must not become active merely because its file
exists. Make system feature decisions in concrete host files and extract shared
composition only after multiple hosts genuinely reuse it. Import one complete
`homes/*.nix` environment from each host or standalone Home Manager output.

## Nix conventions

- Format with `nixfmt` through `just fmt`; keep two-space indentation and the
  existing brace layout.
- Prefer shallow, task-focused feature modules.
- Define feature switches as
  `options.mine.<area>.<name>.enable = lib.mkEnableOption "...";`.
- Gate optional module configuration with `config = lib.mkIf cfg.enable { ... };`.

## Validation

- Run `just fmt` and `just check` for every change.
- Build affected host outputs when changing shared or platform modules:
  `just build <hostname>` on the matching platform.
- For new modules, verify the option is enabled from a host or home environment
  and that evaluation includes the expected package, service, or setting.
- Never run `just switch` as validation unless explicitly asked; it activates
  the configuration on the current host.

## Commits and pull requests

- Match the concise, usually imperative lowercase commit style in history.
- Keep unrelated formatting, input updates, and behavior changes in separate
  commits.
- Pull requests should identify affected hosts or module paths, list validation
  commands, and mention any `flake.lock` changes.

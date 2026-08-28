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

- `flake.nix` is a minimal flake-parts and import-tree bootstrap.
- Every `.nix` file under `modules/` is an automatically discovered
  flake-parts module.
- `modules/apps/`, `modules/cli/`, `modules/development/`, and similar
  directories organize aspects by concept rather than platform.
- Aspects publish typed modules through `flake.modules.<class>.<aspect>`.
- `modules/base.nix` and `modules/gui.nix` contain shared Home Manager
  compositions; `modules/hosts/` defines concrete configurations and outputs.
- `modules/hardware/` publishes typed hardware facets used by hosts.
- `docs/` contains supporting documentation.

Automatic discovery only evaluates flake-parts modules; it does not activate
their published facets. Keep activation explicit through the small Home Manager
environment compositions and concrete hosts. Directory placement is for
navigation and must not determine the dependency graph. Keep raw configuration
assets beside their owning aspect.

## Nix conventions

- Format with `nixfmt` through `just fmt`; keep two-space indentation and the
  existing brace layout.
- Prefer small, task-focused aspects that own all platform implementations of a
  concept.
- Publish reusable facets through the real `darwin`, `nixos`, or `homeManager`
  class; do not use generic modules to bypass type checking.
- Prefer composition over feature-enable options, global `specialArgs`, or
  `_module.args` wiring.

## Validation

- Run `just fmt` and `just check` for every change.
- Build affected host outputs when changing shared or platform modules:
  `just build <hostname>` on the matching platform.
- For new aspects, verify the facet is composed by an environment or host and that
  evaluation includes the expected package, service, or setting.
- Never run `just switch` as validation unless explicitly asked; it activates
  the configuration on the current host.

## Commits and pull requests

- Match the concise, usually imperative lowercase commit style in history.
- Keep unrelated formatting, input updates, and behavior changes in separate
  commits.
- Pull requests should identify affected hosts or module paths, list validation
  commands, and mention any `flake.lock` changes.

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

# Build the current machine or Home Manager profile without activating it
build target="":
    @just _nh build {{ quote(target) }}

# Build and activate the current machine or Home Manager profile
switch target="":
    @just _nh switch {{ quote(target) }}

# Evaluate every flake check
check:
    nix flake check

# Update all flake inputs
update:
    nix flake update

# Update one flake input, e.g. `just update-one nixpkgs`
update-one input:
    nix flake update {{ quote(input) }}

# Update inputs, run checks, and activate the current configuration
upgrade:
    just update
    just check
    just switch

# Remove old generations and store paths
gc:
    nh clean all --keep-since 7d --keep 5

# Format Nix and just files
fmt:
    rg --files -0 -g '*.nix' | xargs -0 nix fmt
    just --unstable --fmt

[private]
_nh action target:
    #!/usr/bin/env bash
    action={{ quote(action) }}
    target={{ quote(target) }}

    case "$(uname -s)" in
        Darwin)
            if [[ -n "$target" ]]; then
                nh darwin "$action" . -H "$target"
            else
                nh darwin "$action" .
            fi
            ;;
        Linux)
            if [[ -e /etc/NIXOS ]]; then
                if [[ -n "$target" ]]; then
                    nh os "$action" . -H "$target"
                else
                    nh os "$action" .
                fi
            elif [[ -n "$target" ]]; then
                nh home "$action" . -c "$target"
            elif [[ -n "${NH_HOME_CONFIG:-}" ]]; then
                nh home "$action" . -c "$NH_HOME_CONFIG"
            else
                echo "No Home Manager configuration specified." >&2
                echo "Use: just $action <configuration>" >&2
                exit 1
            fi
            ;;
        *)
            echo "Unsupported operating system: $(uname -s)" >&2
            exit 1
            ;;
    esac

alias b := build
alias s := switch
alias c := check
alias u := update
alias up := upgrade

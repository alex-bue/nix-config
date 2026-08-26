host := `scutil --get LocalHostName 2>/dev/null || hostname -s`

default:
    @just --list

# Evaluate flake outputs and checks
check:
    nix flake check

# Build Darwin config, but don't activate it
build:
    darwin-rebuild build --flake .#{{ host }}

# Build + activate current Darwin config
switch:
    sudo darwin-rebuild switch --flake .#{{ host }}

# Update all flake inputs
update:
    nix flake update

# Update one input, e.g. `just update-one nixpkgs`
update-one input:
    nix flake update {{ input }}

# Update inputs, verify, then activate
upgrade: update check switch

# Show Darwin generations
generations:
    darwin-rebuild --list-generations

# Roll back to previous Darwin generation
rollback:
    sudo darwin-rebuild --rollback

# Garbage collect old Nix store paths
gc:
    nix-collect-garbage -d

# Build the NixOS VM system closure without switching
build-vm:
    nix build .#nixosConfigurations.nixos-vm.config.system.build.toplevel

# Apply the NixOS VM configuration
vm:
    sudo nixos-rebuild switch --flake .#nixos-vm

# Build a standalone Home Manager profile
home-build profile:
    home-manager build --flake ".#{{ profile }}"

# Build + activate a standalone Home Manager profile
home-switch profile:
    home-manager switch --flake ".#{{ profile }}"

# Format the justfile itself
fmt:
    just --unstable --fmt

alias c := check
alias b := build
alias s := switch
alias mac := switch
alias build-mac := build
alias bv := build-vm

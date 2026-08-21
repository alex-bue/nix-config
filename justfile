host := `scutil --get LocalHostName 2>/dev/null || hostname -s`
server := "homeserver"
server_target := "ab@homeserver"

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

# Build the homeserver config on the homeserver
server-build:
    nixos-rebuild build --flake .#{{ server }} --build-host {{ server_target }}

# Build + activate the homeserver config on the homeserver
server-switch:
    nixos-rebuild switch --flake .#{{ server }} --target-host {{ server_target }} --build-host {{ server_target }} --use-remote-sudo

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

# Format the justfile itself
fmt:
    just --unstable --fmt

alias c := check
alias b := build
alias s := switch
alias mac := switch
alias build-mac := build
alias sb := server-build
alias ss := server-switch
alias bv := build-vm

# nix-templates Justfile
#
# Project scaffolding. Templates are consumed via `nix flake init -t .#<name>`.

[group("Main")]
default:
    @just --list

[group("Linter")]
check:
    @echo "📐 Verifying templates flake..."
    @nix flake check . --impure

[group("Linter")]
fmt:
    @nix fmt

# List every template the flake exposes.
[group("Discovery")]
list-templates:
    @echo "📋 Available templates:"
    @nix eval .#templates --apply 'builtins.attrNames' --json 2>/dev/null \
        | jq -r '.[]' 2>/dev/null \
        || nix flake show .

# Instantiate a template into the target directory.
# Example: `just init python-poetry ~/projects/new-app`
[group("Use")]
init template target:
    @echo "📐 Initialising '{{template}}' into {{target}}..."
    @nix flake init -t .#{{template}} --refresh --extra-experimental-features "nix-command flakes"
    @echo "💡 If you wanted a different directory, move the generated files: mv * '{{target}}'"

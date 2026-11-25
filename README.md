# Nix Templates

This repository contains Nix flake templates for quick project initialization.

## Templates

- `default`: A basic `flake-parts` enabled flake with `treefmt` and `pre-commit-hooks`.
- `module`: A standalone NixOS/Home Manager module flake.

## Usage

Pick one template and run it in an empty project directory:

```bash
nix flake init -t github:kleinbem/nix-templates#default
# or
nix flake init -t github:kleinbem/nix-templates#module
```

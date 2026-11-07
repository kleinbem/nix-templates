# nix-templates

Nix flake templates for quick project initialization, exposed via
`flake.nix`'s `templates` attrset.

## Templates

| Template | Path | What |
|---|---|---|
| `default` | `default/` | Basic `flake-parts`-enabled flake with `treefmt` + `pre-commit-hooks`. Documented in `README.md`. |
| `module` | `module/` | Standalone NixOS/home-manager module template. Not documented in `README.md` — check `flake.nix`'s `templates` attrset before assuming a template doesn't exist. |

## Usage

```bash
nix flake init -t github:kleinbem/nix-templates#default
nix flake init -t github:kleinbem/nix-templates#module
```

## Conventions

- Add a new template as its own top-level directory + one entry in
  `flake.nix`'s `templates` attrset — keep `README.md` and this file in
  sync with that attrset since it's easy for docs to drift from it (as
  happened with `module` above).

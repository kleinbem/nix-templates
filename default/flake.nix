{
  description = "A flake-parts project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          # Formatting
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
          };

          # Pre-commit Checks
          checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt.enable = true;
              statix.enable = true;
              deadnix.enable = true;
            };
          };

          # Development Shell
          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.checks.pre-commit-check.shellHook}
              echo "🛠️  DevShell Loaded"
            '';
            buildInputs = [
              pkgs.nixfmt
              pkgs.statix
              pkgs.deadnix
              pkgs.nil
            ];
          };
        };
    };
}

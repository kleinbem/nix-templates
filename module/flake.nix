{
  description = "A flake for a standalone NixOS/Home Manager module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { system, ... }:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [ pkgs.nixfmt ];
          };
          formatter = pkgs.nixfmt;
        };

      flake = {
        nixosModules.default = import ./default.nix;
        homeManagerModules.default = import ./default.nix;
      };
    };
}

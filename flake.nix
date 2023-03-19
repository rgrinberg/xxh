{
  description = "Xxh Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs, flake-utils, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        inherit (pkgs.ocamlPackages) buildDunePackage;
      in
      rec {
        packages = rec {
          default = xxh;
          xxh = buildDunePackage {
            pname = "xxh";
            version = "n/a";
            src = ./.;
            duneVersion = "3";
            propagatedBuildInputs = with pkgs.ocamlPackages; [ ];
            checkInputs = with pkgs.ocamlPackages; [
              ppx_inline_test
              ppx_expect
            ];
            doCheck = true;
          };
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = pkgs.lib.attrValues packages;
          buildInputs = with pkgs.ocamlPackages; [
            pkgs.ccls
            ocaml-lsp
            pkgs.ocamlformat
            ppx_bench
            core_bench
          ];
        };
      });
}

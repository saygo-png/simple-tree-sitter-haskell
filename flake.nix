{
  description = "distribution of tree-sitter-haskell with minimal queries for Neovim";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems = {
      url = "path:./systems.nix";
      flake = false;
    };

    tree-sitter-haskell = {
      url = "github:tree-sitter/tree-sitter-haskell";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    systems,
    tree-sitter-haskell,
    ...
  }: let
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system: import nixpkgs {inherit system;});
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system pkgsFor.${system});
  in {
    packages = eachSystem (_system: pkgs: rec {
      parser = pkgs.tree-sitter.buildGrammar {
        language = "haskell";
        version = "${(nixpkgs.lib.importJSON "${tree-sitter-haskell}/tree-sitter.json").metadata.version}+rev=${tree-sitter-haskell.shortRev}";
        src = tree-sitter-haskell;

        postInstall = ''
          rm -rf $out/queries
          cp -r ${./queries} $out/queries

          HOME=$TMPDIR ${pkgs.lib.getExe pkgs.neovim-unwrapped} --clean -l ${./check.lua} $out/parser $out/queries/haskell
        '';
      };

      # Neovim plugin with parser/haskell.so and queries/haskell/*.scm.
      # Works both as a plugin and in nvim-treesitter's withPlugins/grammarPackages
      default = pkgs.neovimUtils.grammarToPlugin parser;
    });
  };
}

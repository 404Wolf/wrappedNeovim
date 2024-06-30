{
  description = "Cookiecutter project template collection";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.neovim.overrideAttrs (
          finalAttrs: previousAttrs: {
            postFixup = ''
              ${previousAttrs.postFixup or ""}
              wrapProgram $out/bin/nvim \
                --set PYTHONPATH $PYTHONPATH:${pkgs.python312Packages.std2}/lib:${pkgs.python312Packages.pynvim-pp}/lib:${pkgs.python312Packages.pyyaml}/lib \
                --set PATH $PATH:${
                  pkgs.lib.makeBinPath [
                    pkgs.nodejs_22
                    pkgs.git
                    pkgs.nixd
                    pkgs.nodePackages.prettier
                    pkgs.nodePackages_latest.typescript-language-server
                    pkgs.luajitPackages.lua-lsp
                    pkgs.lua-language-server
                    pkgs.basedpyright
                    pkgs.stylua
                    pkgs.prettierd
                    pkgs.nixfmt-rfc-style
                    pkgs.black # Python formatter
                    pkgs.isort # Python import sorter
                    pkgs.go_1_21 # Go formatter
                    pkgs.nodePackages_latest.bash-language-server
                    pkgs.yaml-language-server
                    pkgs.vscode-langservers-extracted
                    pkgs.gosimports
                    pkgs.beautysh
                    pkgs.rustc
                    pkgs.cargo
                    pkgs.rust-analyzer
                    pkgs.ripgrep
                    pkgs.fd
                    pkgs.rustfmt
                    pkgs.pandoc
                    pkgs.tree-sitter
                    pkgs.tree-sitter-grammars.tree-sitter-typst
                    pkgs.tree-sitter-grammars.tree-sitter-latex
                    pkgs.tree-sitter-grammars.tree-sitter-yaml
                    pkgs.tree-sitter-grammars.tree-sitter-vim
                    pkgs.tree-sitter-grammars.tree-sitter-typescript
                    pkgs.tree-sitter-grammars.tree-sitter-toml
                    pkgs.tree-sitter-grammars.tree-sitter-sql
                    pkgs.tree-sitter-grammars.tree-sitter-scss
                    pkgs.tree-sitter-grammars.tree-sitter-rust
                    pkgs.tree-sitter-grammars.tree-sitter-r
                    pkgs.tree-sitter-grammars.tree-sitter-regex
                    pkgs.tree-sitter-grammars.tree-sitter-python
                    pkgs.tree-sitter-grammars.tree-sitter-prisma
                    pkgs.tree-sitter-grammars.tree-sitter-php
                    pkgs.tree-sitter-grammars.tree-sitter-perl
                    pkgs.tree-sitter-grammars.tree-sitter-nix
                    pkgs.tree-sitter-grammars.tree-sitter-markdown
                    pkgs.tree-sitter-grammars.tree-sitter-markdown-inline
                    pkgs.tree-sitter-grammars.tree-sitter-lua
                    pkgs.tree-sitter-grammars.tree-sitter-julia
                    pkgs.tree-sitter-grammars.tree-sitter-json
                    pkgs.tree-sitter-grammars.tree-sitter-javascript
                    pkgs.tree-sitter-grammars.tree-sitter-java
                    pkgs.tree-sitter-grammars.tree-sitter-html
                    pkgs.tree-sitter-grammars.tree-sitter-haskell
                    pkgs.tree-sitter-grammars.tree-sitter-graphql
                    pkgs.tree-sitter-grammars.tree-sitter-go
                    pkgs.tree-sitter-grammars.tree-sitter-fish
                    pkgs.tree-sitter-grammars.tree-sitter-dockerfile
                  ]
                }
            '';
          }
        );
      }
    );
}

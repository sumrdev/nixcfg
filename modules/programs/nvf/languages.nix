{
  lib,
  pkgs,
  inputs,
  ...
}: {
  vim = {
    extraPackages = [
      pkgs.roslyn-ls
      pkgs.dotnet-sdk_10
    ];
    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      assembly.enable = true;
      bash.enable = true;
      clang.enable = true;
      csharp = {
        enable = true;
        lsp = {
          enable = true;
          servers = ["roslyn-ls"];
        };
      };
      css.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix = {
        enable = true;
        lsp = {
          servers = ["nil"];
        };
      };
      python = {
        enable = true;
        format.type = ["ruff"];
      };
      tailwind.enable = true;
      html = {
        enable = true;
        lsp.servers = ["emmet-ls"];
      };
      ts = {
        enable = true;
        lsp = {
          servers = ["ts_ls"];
        };
      };
      yaml.enable = true;
      rust.enable = true;
    };
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        lua = [
          "stylua"
        ];
        vue = [
          "prettier"
          "eslint"
        ];
        cs = [
          "csharpier"
        ];
      };
    };
  };
}

{pkgs, ...}: {
  vim = {
    extraPackages = [
      pkgs.dotnet-sdk_10
    ];

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      bash.enable = true;
      csharp = {
        enable = true;
        lsp = {
          enable = false;
        };
      };
      css.enable = true;
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
      vue.format.enable = true;
      typescript = {
        enable = true;
        lsp = {
          servers = ["typescript-language-server"];
        };
      };
      yaml.enable = true;
    };
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        lua = [
          "stylua"
        ];
        vue = [
          "prettierd"
        ];
        cs = [
          "csharpier"
        ];
      };
    };
  };
}

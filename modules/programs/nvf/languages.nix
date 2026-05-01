{pkgs, ...}: {
  vim = {
    extraPackages = [
      pkgs.roslyn-ls
      pkgs.dotnet-sdk_10
    ];

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      bash.enable = true;
      csharp = {
        enable = true;
        extensions.roslyn-nvim.setupOpts.extensions.razor.enabled = true;
        lsp = {
          enable = true;
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

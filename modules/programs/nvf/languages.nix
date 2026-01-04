{
  lib,
  pkgs,
  inputs,
  ...
}: {
  vim.languages = {
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    assembly.enable = true;
    bash.enable = true;
    clang.enable = true;
    csharp = {
      enable = false;
      lsp = {
        servers = ["roslyn_ls"];
      };
    };
    css.enable = true;
    html.enable = true;
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
    ts.enable = true;
    yaml.enable = true;
    rust.enable = true;
  };
}

{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  staticLogDir = "/tmp/roslyn-ls-logs";
in {
  vim.lsp.servers.roslyn_ls = {
    enable = true;
    filetypes = ["cs"];
    root_markers = [
      ".csproj"
      ".sln"
      ".git"
    ];
    cmd = [
      (lib.getExe pkgs.roslyn-ls)
      "--logLevel=Warning"
      "--extensionLogDirectory=${staticLogDir}"
      "--stdio"
    ];
    capabilities = mkLuaInline "capabilities";
    on_attach = mkLuaInline ''
      function(client)
        if vim.bo.filetype == 'cs' then
          client.server_capabilities.semanticTokensProvider.full = false
        else
          client.server_capabilities.semanticTokensProvider.full = true
        end
      end
    '';
  };
}

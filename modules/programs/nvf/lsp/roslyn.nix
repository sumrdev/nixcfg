{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  # programs.nvf.settings.vim.lsp.servers.roslyn_ls = {
  #   enable = false;
  #   filetypes = ["cs"];
  #   root_markers = [
  #     ".csproj"
  #     ".sln"
  #   ];
  #   cmd = [
  #     (lib.getExe pkgs.roslyn-ls)
  #     "--logLevel=Warning"
  #     "--stdio"
  #   ];
  #   capabilities = mkLuaInline "capabilities";
  #   on_attach = mkLuaInline ''
  #     function(client)
  #       if vim.bo.filetype == 'cs' then
  #         client.server_capabilities.semanticTokensProvider.full = false
  #       else
  #         client.server_capabilities.semanticTokensProvider.full = true
  #       end
  #     end
  #   '';
  # };
}

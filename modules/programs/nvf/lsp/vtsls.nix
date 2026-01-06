{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim.lsp.servers.vtsls = {
    enable = true;

    capabilities = mkLuaInline "capabilities";
    on_attach = mkLuaInline ''
      function(client)
        if vim.bo.filetype == 'vue' then
          client.server_capabilities.semanticTokensProvider.full = false
        else
          client.server_capabilities.semanticTokensProvider.full = true
        end
      end
    '';

    filetypes = [
      "typescript"
      "javascript"
      "javascriptreact"
      "typescriptreact"
      "vue"
    ];
    root_markers = ["tsconfig.json" "jsconfig.json" "package.json" ".git"];

    cmd = [
      "${lib.getExe pkgs.vtsls}"
      "--stdio"
    ];

    settings = {
      typescript = {
        updateImportsOnFileMove.enabled = "always";
        tsserver.maxTsServerMemory = 8192;
      };
      vtsls = {
        enableMoveToFileCodeAction = true;
        experimental.completion.enableServerSideFuzzyMatch = true;

        tsserver = {
          globalPlugins = [
            {
              name = "@vue/typescript-plugin";
              location = "${lib.getBin pkgs.vue-language-server}/lib/language-tools/packages/language-server";
              languages = ["vue"];
              configNamespace = "typescript";
            }
          ];
        };
      };
    };
  };
}

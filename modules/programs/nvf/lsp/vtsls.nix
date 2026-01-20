{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim.lsp.servers.vtsls = {
    enable = true;
    on_attach = mkLuaInline ''
      function(client, bufnr)
        -- Disable semantic tokens for Vue files to prevent highlighting conflicts
        if vim.bo[bufnr].filetype == 'vue' then
          client.server_capabilities.semanticTokensProvider = nil
        else
          client.server_capabilities.semanticTokensProvider.full = true
        end
      end
    '';

    filetypes = [
      "javascript"
      "javascriptreact"
      "javascript.jsx"
      "typescript"
      "typescriptreact"
      "typescript.tsx"
      "vue"
    ];
    root_markers = ["tsconfig.json" "jsconfig.json" "package.json" ".git"];

    cmd = [
      (lib.getExe pkgs.vtsls)
      "--stdio"
    ];

    settings = {
      vtsls = {
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

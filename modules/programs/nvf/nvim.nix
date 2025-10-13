{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = false;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      imports = [
        ./lsp/roslyn.nix
        ./lsp/vtsls.nix
        ./languages.nix
        ./keymaps.nix
      ];
      vim = {
        viAlias = false;
        vimAlias = true;
        # autopairs.nvim-autopairs.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
          # lspSignature.enable = true;
        };
        theme = {
          enable = true;
          name = "rose-pine";
          style = "main";
        };
        options = {
          shiftwidth = 2;
          tabstop = 2;
          autoindent = true;
          expandtab = true;
          conceallevel = 2;
          scrolloff = 10;
        };
        searchCase = "smart";
        syntaxHighlighting = true;
        luaConfigRC.clipboard = ''
          vim.opt.clipboard:append("unnamedplus")
        '';
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };
        comments.comment-nvim = {
          enable = true;
        };
        treesitter = {
          enable = true;
          autotagHtml = true;
        };
        utility.oil-nvim.enable = true;
        telescope.enable = true;
        git = {
          enable = true;
          gitsigns = {
            enable = true;
            codeActions.enable = false;
          };
          vim-fugitive.enable = true;
        };
      };
    };
  };
}

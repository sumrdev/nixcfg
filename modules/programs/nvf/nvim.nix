{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      imports = [
        # ./lsp/roslyn.nix
        # ./lsp/vtsls.nix
        ./languages.nix
        ./keymaps.nix
      ];
      vim = {
        dashboard = {
          alpha = {
            enable = true;
            theme = "theta";
          };
        };
        viAlias = false;
        vimAlias = true;
        autopairs.nvim-autopairs.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
          mappings = {
            codeAction = "<leader>ca";
            goToDeclaration = "<leader>gD";
            goToDefinition = "<leader>gd";
            listReferences = "<leader>gr";
            renameSymbol = "<leader>ra";
          };
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
          mappings = {
            toggleCurrentLine = "<leader>/";
            toggleSelectedLine = "<leader>/";
          };
        };
        treesitter = {
          enable = true;
          autotagHtml = true;
        };
        utility.oil-nvim.enable = true;
        telescope = {
          setupOpts = {
            defaults.layout_config.horizontal.prompt_position = "bottom";
            defaults.sorting_strategy = "descending";
          };
          enable = true;
        };
        git = {
          enable = true;
          gitsigns = {
            enable = true;
            codeActions.enable = false;
          };
          vim-fugitive.enable = true;
        };
        extraPlugins = with pkgs.vimPlugins; {
          roslyn = {
            package = roslyn-nvim;
            setup = "require('roslyn').setup({})";
          };
        };
      };
    };
  };
}

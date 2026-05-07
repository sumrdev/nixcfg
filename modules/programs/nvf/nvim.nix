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
        ./languages.nix
        ./keymaps.nix
      ];
      vim = {
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
          presets = {
            tailwindcss-language-server.enable = true;
            vtsls.enable = true;
          };
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
          style = "moon";
          transparent = true;
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
          autotagHtml = false;
        };
        utility.oil-nvim.enable = true;
        telescope = {
          setupOpts = {
            defaults = {
              layout_config.horizontal.prompt_position = "bottom";
              sorting_strategy = "descending";
              vimgrep_arguments = [
                "rg"
                "--color=never"
                "--no-heading"
                "--with-filename"
                "--line-number"
                "--column"
                "--smart-case"
                "--trim"
              ];
            };
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
            setup = ''
              require('roslyn').setup({
                filewatching = "off",
              })
            '';
          };
        };
      };
    };
  };
}

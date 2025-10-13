{
  lib,
  pkgs,
  inputs,
  ...
}: {
  vim.keymaps = [
    {
      key = "-";
      mode = ["n"];
      action = ":Oil<CR>";
      desc = "Oil";
    }
    {
      key = "<leader>wq";
      mode = ["n"];
      action = ":wq<CR>";
      silent = true;
      desc = "Save file and quit";
    }
    {
      key = "<leader>fw";
      mode = ["n"];
      action = ":Telescope live_grep<CR>";
      silent = true;
      desc = "Telescope grep";
    }
    {
      key = "<leader>fe";
      mode = ["n"];
      action = ":Telescope diagnostics<CR>";
      silent = true;
      desc = "Telescope find errors";
    }
    {
      key = "<leader>/";
      mode = ["n"];
      action = "gcc";
      desc = "Comment line";
    }

    {
      key = "<leader>/";
      mode = ["v"];
      action = "gc";
      desc = "Comment/uncomment selection";
    }
    {
      key = "<leader>le";
      mode = ["n"];
      action = ":lua vim.diagnostic.open_float()<CR>";
      silent = true;
      desc = "Show error";
    }
    {
      key = "<leader>ca";
      mode = ["n"];
      action = ":lua vim.lsp.buf.code_action()<CR>";
      silent = true;
      desc = "Code action";
    }
    {
      key = "<leader>gd";
      mode = ["n"];
      action = ":lua vim.lsp.buf.definition()<CR>";
      desc = "LSP Go to Definition";
    }
    {
      key = "<leader>gi";
      mode = ["n"];
      action = ":lua vim.lsp.buf.implementation()<CR>";
      desc = "LSP Go to Implementation";
    }
    {
      key = "<leader>gD";
      mode = ["n"];
      action = ":lua vim.lsp.buf.declaration()<CR>";
      desc = "LSP Go to Declaration";
    }
    {
      key = "<leader>gt";
      mode = ["n"];
      action = ":lua vim.lsp.buf.type_definition()<CR>";
      desc = "LSP Go to Type Definition";
    }
    {
      key = "<leader>gr";
      mode = ["n"];
      action = ":lua vim.lsp.buf.references()<CR>";
      desc = "LSP See References";
    }

    {
      key = "<leader>rn";
      mode = ["n"];
      action = ":lua vim.lsp.buf.rename()<CR>";
      desc = "LSP Rename Symbol";
    }
    {
      key = "K";
      mode = ["n"];
      action = ":lua vim.lsp.buf.hover()<CR>";
      desc = "LSP Hover Documentation";
    }
    {
      key = "<C-k>";
      mode = ["n" "i"];
      action = ":lua vim.lsp.buf.signature_help()<CR>";
      desc = "LSP Signature Help";
    }
    {
      key = ";";
      mode = ["n"];
      action = ":";
      silent = true;
      desc = "swap ; for :";
    }
    {
      key = ":";
      mode = ["n"];
      action = ";";
      silent = true;
      desc = "swap : for ;";
    }
  ];
}

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

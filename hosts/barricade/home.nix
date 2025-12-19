{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/programs/fish.nix
    ../../modules/programs/git.nix
    ../../modules/programs/jujutsu.nix
    ../../modules/programs/nvf/nvim.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/zoxide.nix
    inputs.nvf.homeManagerModules.default
  ];
  home = {
    packages = with pkgs; [
      wget
      ripgrep
      tree
      python3

      vtsls

      lua
      vue-language-server
      vscode-langservers-extracted
      prettierd
      ghostscript
      neovim
      gemini-cli
    ];

    username = "ms";
    homeDirectory = "/home/ms";

    stateVersion = "26.05";
  };
  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

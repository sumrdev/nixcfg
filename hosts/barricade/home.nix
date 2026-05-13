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
      ghostscript
      vue-language-server
      roslyn-ls
    ];

    username = "ms";
    homeDirectory = "/home/ms";

    stateVersion = "26.05";
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_10}";
    };
  };
  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

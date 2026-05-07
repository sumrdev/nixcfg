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
    helix = {
      enable = true;
      defaultEditor = false;
      languages = {
        language-server = {
          volar = {
            command = "${pkgs.vue-language-server}/bin/vue-language-server";
            args = ["--stdio"];
          };
          # csharp-ls = {
          #   command = "${pkgs.csharp-ls}/bin/csharp-ls";
          # };

          # Alternative: Microsoft's official roslyn-ls
          # (Uncomment this and the language server array below if you prefer it over csharp-ls)
          roslyn = {
            command = "${pkgs.roslyn-ls}/bin/Microsoft.CodeAnalysis.LanguageServer";
          };
        };

        language = [
          {
            name = "vue";
            auto-format = true;
            language-servers = ["vuels"];
          }
          {
            name = "c-sharp";
            auto-format = true;
            language-servers = ["csharp-ls"];
          }
        ];
      };
    };
  };
}

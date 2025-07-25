# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "ms";
  networking.hostName = "nix";

  time.timeZone = "Europe/Copenhagen";

  system.stateVersion = "25.05";

  environment.systemPackages = with pkgs; [
    fish
    jujutsu
    neovim
    python3
    git
    zoxide
    fzf
    ripgrep
    gcc
    nil
    prettier
    csharpier
    pnpm
    stylua
    nodejs_22
    rustfmt
    eslint_d
    eslint
    lua
    luarocks
    black
    prettierd
    isort
    dotnetCorePackages.sdk_8_0-bin
    dotnetCorePackages.runtime_8_0-bin
    dotnetCorePackages.aspnetcore_8_0-bin
    gopls
    glibc

    lua-language-server
    pyright
    clang-tools
    vtsls
    fsautocomplete
    vscode-langservers-extracted
    csharp-ls
    emmet-language-server
    rust-analyzer
    tailwindcss-language-server
  ];
  nixpkgs.hostPlatform = "x86_64-linux";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";

  users.users.ms = {
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ libsecret ];
  };

  home-manager.users.ms = {
    home.stateVersion = "25.05";

    programs = {
      git = {
        enable = true;
        userName = "Marius Nielsen ";
        userEmail = "msn@uxvtechnologies.com";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [ "--cmd cd" ];
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          set EDITOR nvim
        '';
        plugins = [
          {
            name = "plugin-git";
            src = pkgs.fishPlugins.plugin-git.src;
          }
        ];
      };
      tmux = {
        enable = true;
        escapeTime = 0;
        mouse = true;
        shortcut = "Space";
        plugins = with pkgs.tmuxPlugins; [
          sensible
          kanagawa
        ];
        extraConfig = ''
          set -g status-position top
          set -g default-terminal "tmux-256color"
          set-option -ga terminal-overrides ",xterm-256color:Tc"
          # Enable 256 colors
          set -g default-terminal "tmux-256color"

          set -ga terminal-overrides ",xterm-256color:RGB" # for 256-color terminals to handle true color
          set -ga terminal-overrides ",*:Smulx=\\E[4::%p1%dm" # undercurl support
          set -ga terminal-overrides ",*:Setulc=\\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m" 

          # If you're on a very recent tmux version and want to explicitly use a true color terminfo,
          # you might use "tmux-truecolor" instead of "tmux-256color" for default-terminal,
          # but "tmux-256color" with the overrides is generally more compatible.
          # set -g default-terminal "tmux-truecolor"
          # set -ga terminal-overrides ",tmux-truecolor:Tc" # Tc means true color
        '';
      };
    };
  };
  documentation.man.generateCaches = false;
  programs.fish.enable = true;
}

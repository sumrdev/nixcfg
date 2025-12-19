# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  outputs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    ../../modules/programs/comma.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "ms";
  networking.hostName = "barricade";

  time.timeZone = "Europe/Copenhagen";

  system.stateVersion = "26.05";
  services.envfs.enable = false;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      gcc
      dotnet-sdk_8
      neovim
      nil
      emmet-language-server
      chromium
    ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    users.ms = {
      imports = [./home.nix];
    };
    extraSpecialArgs = {inherit inputs;};
  };

  users.users.ms = {
    shell = pkgs.fish;
    extraGroups = ["docker"];
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [libsecret];
    };
    fish.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "ms"
    ];
  };
  nix.gc = {
    automatic = true;
    # Set the frequency for the garbage collector to run.
    # Options include "daily", "weekly", or a systemd-style calendar specification.
    dates = "daily";
    # These are the arguments passed to 'nix-collect-garbage'.
    # This achieves your desired 'sudo nix-collect-garbage --delete-older-than 30d'
    options = "--delete-older-than 7d";
  };

  documentation.man.generateCaches = false;
}

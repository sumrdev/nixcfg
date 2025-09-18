# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  wsl.enable = true;
  wsl.defaultUser = "ms";
  networking.hostName = "nix";

  time.timeZone = "Europe/Copenhagen";

  system.stateVersion = "25.05";
  services.envfs.enable = true;
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
      inputs.pinix.packages.${pkgs.system}.default
      gcc
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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libsecret];
  };
  documentation.man.generateCaches = false;
}

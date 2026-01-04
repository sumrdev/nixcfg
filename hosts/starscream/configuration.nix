# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ms = {
      imports = [
        ./home.nix
      ];
    };
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
  };

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "starscream";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Copenhagen";

  users.users.ms = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ];
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services = {
    envfs.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    goxlr-utility.autoStart.xdg = true;
    tailscale.enable = true;
  };

  programs = {
    hyprland.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = 1;
    };
    systemPackages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      gcc
      glibc
      goxlr-utility
      comma
      openh264
      firefox
    ];
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
  system.stateVersion = "26.05"; # Did you read the comment?
}

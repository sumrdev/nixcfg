# Edit this configuration file to define what should be installed onblacy
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

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

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

  networking = {
    hostName = "blackout";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      checkReversePath = false;
    };
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
    fish = {
      enable = true;
      useBabelfish = true;
    };
    nix-ld.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = 1;
    };
    systemPackages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${stdenv.hostPlatform.system}.default
      gcc
      glibc
      goxlr-utility
      sbctl
      steam-run
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
  system.stateVersion = "24.11"; # Did you read the comment?
}

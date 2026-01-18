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
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-d94cc1fb-71ee-4305-ada2-9409d4e1cacf".device = "/dev/disk/by-uuid/d94cc1fb-71ee-4305-ada2-9409d4e1cacf";

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

  networking = {
    hostName = "brawl";
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
    tailscale.enable = true;
    openssh.enable = true;
  };

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
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
      inputs.rose-pine-hyprcursor.packages.${stdenv.hostPlatform.system}.default
      gcc
      glibc
      sbctl
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
  system.stateVersion = "25.05"; # Did you read the comment?
}

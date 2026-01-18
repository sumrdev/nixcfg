{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/services/tailscale.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs.config.allowUnfree = true;
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl."net.ipv4.ip_forward" = 1;

    initrd.luks.devices."luks-d94cc1fb-71ee-4305-ada2-9409d4e1cacf".device = "/dev/disk/by-uuid/d94cc1fb-71ee-4305-ada2-9409d4e1cacf";
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
  systemd.services.proton-port-forward = {
    description = "Maintain Proton VPN Port Forwarding";
    after = ["network-online.target" "wireguard-wg0.service"];
    wants = ["network-online.target" "wireguard-wg0.service"];
    wantedBy = ["multi-user.target"];

    path = with pkgs; [
      libnatpmp
      bash
      coreutils
    ];

    script = ''
      echo "Starting Proton Port Forwarding loop..."
      while true; do
        date
        # Using your working logic:
        # -a 1 0 [proto] [lifetime] -g [gateway]
        natpmpc -a 1 0 udp 60 -g 10.2.0.1 && \
        natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || \
        { echo -e "ERROR with natpmpc command" ; break ; }

        sleep 45
      done
    '';

    serviceConfig = {
      Type = "simple";
      User = "root";
      Restart = "always";
      RestartSec = "20";
    };
  };
  networking = {
    nat.enable = true;
    firewall.allowedUDPPorts = [51820];

    wireguard.interfaces = {
      wg0 = {
        ips = ["10.2.0.2/32"];
        privateKeyFile = "/var/lib/secrets/wireguard";

        postSetup = ''
          ${pkgs.openresolv}/bin/resolvconf -a wg0 <<EOF
          nameserver 10.2.0.1
          EOF

          ${pkgs.iproute2}/bin/ip route add 10.0.0.0/24 dev enp0s25 table main || true
          ${pkgs.iproute2}/bin/ip route add 149.88.109.33 via 10.0.0.1 dev enp0s25 || true
        '';

        # Cleanup DNS on shutdown
        postShutdown = ''
          ${pkgs.openresolv}/bin/resolvconf -d wg0
        '';

        peers = [
          {
            publicKey = "fJt+VGA6v6VoXWZ0pxf6XQWZFUH/5A4tPLxMMWasHzI=";
            allowedIPs = ["0.0.0.0/0" "::/0"];
            endpoint = "149.88.109.33:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
    hostName = "brawl";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      checkReversePath = "loose";
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
      libnatpmp
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

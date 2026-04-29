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
    ../../modules/services/cups.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "ms";
  networking.hostName = "barricade";
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Copenhagen";

  system.stateVersion = "26.05";
  services.envfs.enable = false;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      gcc
      chromium
      kubectl
      codex
      opencode
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
    fish = {
      enable = true;
      useBabelfish = true;
    };
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

  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      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
      vuLNOyzAYQ2MGny1Uj/sBwd0Vw==
      -----END CERTIFICATE-----
    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIDtzCCAp+gAwIBAgIIM3DVmn0tkpYwDQYJKoZIhvcNAQELBQAwQjEoMCYGA1UE
      AwwfVW5pRmkgU1NMIENlcnRpZmljYXRlIEF1dGhvcml0eTEWMBQGA1UECgwNVWJp
      cXVpdGkgSW5jLjAeFw0yNDEwMDExNjExMTFaFw0zNDA5MjkxNjExMTFaMEIxKDAm
      BgNVBAMMH1VuaUZpIFNTTCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxFjAUBgNVBAoM
      DVViaXF1aXRpIEluYy4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCW
      O2kjCIq5Tou+6xSkc95DZyHwRTa8rJCsWIJe642GgqBffPhfjv2Fw5NyZB3nlPq1
      opRNOCQbjvWzV2K75E1oLnRVWFKREX52pg9vqhhC0N8c72/D/sykA87rsgDpLEOs
      TacYAaL2L0O9hiEWiFn88x4hlt4qUniRRr3eCGFyPhArjKE/uc/9yie1UCDFicPn
      AlIZyFNm9fc0VBjZsHoKLRP7TZ8mFfDLPz8kuwzQhkHf+dKFJjjjwg4ULRXPjs41
      CcYEpYjLc9cKFlGCC1+UaMLNfaFu7t0INBxo6pzZyVcfR7Yepox3LqoBwAfuPhom
      SceX198MM/zWO/8Do0+HAgMBAAGjgbAwga0wCwYDVR0PBAQDAgEGMAwGA1UdEwQF
      MAMBAf8wcQYDVR0jBGowaIAUuufINwsb8qFch+0VusTuHg2ebiWhRqREMEIxKDAm
      BgNVBAMMH1VuaUZpIFNTTCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxFjAUBgNVBAoM
      DVViaXF1aXRpIEluYy6CCDNw1Zp9LZKWMB0GA1UdDgQWBBS658g3CxvyoVyH7RW6
      xO4eDZ5uJTANBgkqhkiG9w0BAQsFAAOCAQEAOcsGWfxNjZC+lIbFJUTKs4dEkB/e
      KiR0Iz1iiCDNie8867luPYGhSwpOOUQuC8lKa3E7B46tirMWsyftt/DfbNHK5siG
      a6btdWMLhXDsPfLXpKvBHUtFykt7cQNJEesnwjeAzO8t/XOpBiSV3m1C381oG1o+
      +pL619Ep+8t+pebLOVf1cVuDVihtY+JEuZHuMI/soPx8XvNiZto0ntHg7BrWWVJr
      X9+T5lTNJIX8wetN01c6lrOmoPO/hTSaYXo6Odn2Fiw87uetzoYwFIyq5xu7CLO3
      XTiQJAXdXfcTiQUeTqm77xMmrFAkyrquzkRnRPZO8Jz1/Xwarvp4OvY/7Q==
      -----END CERTIFICATE-----
    ''
  ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  documentation.man.generateCaches = false;
}

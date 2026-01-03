{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/programs/hyprlock.nix
    ../../modules/programs/fish.nix
    ../../modules/programs/git.nix
    ../../modules/programs/jujutsu.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/nvf/nvim.nix
    ../../modules/programs/spicetify.nix
    ../../modules/programs/obs-studio.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/waybar/waybar.nix
    ../../modules/programs/zen-browser.nix
    ../../modules/programs/zoxide.nix
    ../../modules/services/hyprpaper.nix
    ../../modules/wayland/hyprland.nix
    inputs.zen-browser.homeModules.twilight
    inputs.spicetify-nix.homeManagerModules.default
    inputs.vicinae.homeManagerModules.default
    inputs.nvf.homeManagerModules.default
  ];
  home = {
    packages = with pkgs; [
      wget
      wl-clipboard
      hyprshot
      hyprpicker
      fastfetch
      protonvpn-gui
      ripgrep
      gowall
      vesktop
      jujutsu
      comma

      tree

      python3
      neovim
      pavucontrol
      nautilus
      yaak
      openvpn
    ];

    username = "ms";
    homeDirectory = "/home/ms";

    stateVersion = "24.11";
  };
  wayland.windowManager.hyprland.settings.monitor = lib.mkForce [
    "DP-2, 2560x1440@360,0x0,1"
    "HDMI-A-1, 1920x1080@240, 2560x-200, 1, transform, 3"
  ];

  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkForce "grp:alt_shift_toggle";

  services = {
    hyprpaper.settings.preload = lib.mkForce [
      "/home/ms/.config/nixcfg/wallpapers/kanagawa.jpg"
    ];
    hyprpaper.settings.wallpaper = lib.mkForce [
      "DP-2, /home/ms/.config/nixcfg/wallpapers/kanagawa.jpg"
      "HDMI-A-1, /home/ms/.config/nixcfg/wallpapers/kanagawa.jpg"
    ];
    vicinae.enable = true;
  };
  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    cava.enable = true;
    cavalier.enable = true;
  };
}

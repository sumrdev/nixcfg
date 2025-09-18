{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/programs/hyprlock.nix
    ../../modules/programs/fish.nix
    ../../modules/programs/jujutsu.nix
    ../../modules/programs/git.nix
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

      tree
      python3
      pavucontrol
      nautilus
    ];

    username = "ms";
    homeDirectory = "/home/ms";

    stateVersion = "25.05";
  };
  services = {
    vicinae.enable = true;
  };
  wayland.windowManager.hyprland.settings.monitor =
    lib.mkForce
    [
      "eDP-1,2880x1920@120,0x0,2"
    ];

  services.hyprpaper.settings.preload =
    lib.mkForce
    [
      "/home/ms/.config/nixcfg/wallpapers/kanagawa.jpg"
    ];
  services.hyprpaper.settings.wallpaper =
    lib.mkForce
    [
      "eDP-1, /home/ms/.config/nixcfg/wallpapers/kanagawa.jpg"
    ];

  programs.waybar.settings.mainbar.modules-right = ["battery"];
  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    cava.enable = true;
    cavalier.enable = true;
  };
}

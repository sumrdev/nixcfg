{
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "~/.config/nixcfg/wallpaper/kanagawa.jpg"
        "~/.config/nixcfg/wallpaper/kanagawa.jpg"
      ];
      wallpaper = [
        "DP-3, ~/.config/nixcfg/wallpapers/kanagawa.jpg"
        "HDMI-A-1, ~/.config/nixcfg/wallpapers/kanagawa.jpg"
      ];
    };
  };
}

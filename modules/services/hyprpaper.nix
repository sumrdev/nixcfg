{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "DP-2";
          path = "~/.config/nixcfg/wallpapers/kanagawa.jpg";
        }
        {
          monitor = "HDMI-A-1";
          path = "~/.config/nixcfg/wallpapers/kanagawa.jpg";
        }
      ];
    };
  };
}

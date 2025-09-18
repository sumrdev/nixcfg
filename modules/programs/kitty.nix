{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "CaskaydiaCove Nerd Font Mono";
      enable_audio_bell = false;

      background = "#1F1F28";
      foreground = "#DCD7BA";
      selection_background = "#2D4F67";
      selection_foreground = "#C8C093";
      url_color = "#72A7BC";
      cursor = "#C8C093";
      color0 = "#16161D ";
      color1 = "#C34043 ";
      color2 = "#76946A ";
      color3 = "#C0A36E ";
      color4 = "#7E9CD8 ";
      color5 = "#957FB8 ";
      color6 = "#6A9589 ";
      color7 = "#C8C093 ";
      color8 = "#727169";
      color9 = "#E82424";
      color10 = "#98BB6C";
      color11 = "#E6C384";
      color12 = "#7FB4CA";
      color13 = "#938AA9";
      color14 = "#7AA89F";
      color15 = "#DCD7BA";

      active_tab_background = "#414b50";
      active_tab_foreground = "#d3c6aa";
      inactive_tab_background = "#272e33";
      inactive_tab_foreground = "#a7c080";

      cursor_shape = "block";
      shell_integration = "no-cursor";
    };
  };
}

{
  lib,
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$discord" = "vesktop";
      "$runner" = "vicinae";
      monitor = [
        "DP-3, 1920x1080@240,0x0,1"
        "HDMI-A-1, 1920x1080@240, -1080x-200, 1, transform, 1"
      ];
      general = {
        gaps_in = 0;
        gaps_out = 2;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = lib.mkDefault "rgba(817B97ff)";
        "col.inactive_border" = lib.mkDefault "rgba(00000000)";
      };
      decoration = {
        rounding = 8;
        active_opacity = 0.8;
        inactive_opacity = 0.8;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = false;
      };
      exec-once = [
        "waybar"
        "hyprpaper"
      ];
      bind = [
        "$mod, B, exec, $browser"
        "$mod, T, exec, $terminal"
        "$mod, D, exec, $discord"
        "$mod, Q, exec, kitty"
        "$mod, R, exec, $runner"
        "$mod, F, fullscreen"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, L, exec, hyprlock"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SUPER_SHIFT, S, exec, hyprshot --clipboard-only -m region"
        "$mod SUPER_SHIFT, C, exec, hyprpicker -a"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      input = {
        kb_layout = "us,dk";
        kb_options = "grp:alt_shift_toggle,caps:swapescape";
        repeat_rate = 55;
        repeat_delay = 225;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      ];
    };
  };
}

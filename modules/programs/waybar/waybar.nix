{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      mainbar = {
        position = "bottom";
        height = 30;
        spacing = 4;
        modules-center = [
          "sway/window"
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "keyboard-state"
          "clock"
          "tray"
        ];
        "cpu" = {
          format = "{usage}% cpu";
          tooltip = false;
        };
        "memory" = {
          format = "{}% mem";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        "hyprland/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          all-outputs = true;
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            urgent = "!";
            active = "x";
            default = "$";
          };
        };
        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        "tray".spacing = 10;
        "clock" = {
          format = "{:%R %d/%m}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };
  };
}

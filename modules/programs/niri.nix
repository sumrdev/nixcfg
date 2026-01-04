{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.niri.settings = {
    # Monitor Setup
    outputs."DP-2" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 360.0;
      };
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
    };
    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 240.0;
      };
      position = {
        x = 1080;
        y = -200;
      };
      transform.rotation = 270; # Equivalent to Hyprland transform 3
      scale = 1.0;
    };

    # Input & Keyboard
    input = {
      keyboard.layout = "us,dk";
      keyboard.xkb-options = "grp:alt_shift_toggle,caps:swapescape";
      keyboard.repeat-rate = 55;
      keyboard.repeat-delay = 225;

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      mouse.accel-speed = 0.0;
      follow-mouse.enable = true;
    };

    # Visuals & Layout
    layout = {
      gaps = 2;
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#817B97ff";
        inactive.color = "#00000000";
      };
      default-column-width = {proportion = 0.5;};
    };

    # Window Rules (Workspace Assignments)
    window-rules = [
      {
        matches = [{app-id = "kitty";}];
        open-on-workspace = "1";
      }
      {
        matches = [{app-id = "^zen(-browser)?$";}];
        open-on-workspace = "3";
      }
      {
        matches = [{app-id = "vesktop";}];
        open-on-workspace = "5";
      }
    ];

    # Keybindings
    binds = with pkgs; {
      # Applications
      "Super+B".action = spawn "zen";
      "Super+T".action = spawn "kitty";
      "Super+D".action = spawn "vesktop";
      "Super+Q".action = spawn "kitty";
      "Super+R".action = spawn "vicinae" "toggle";

      # Window Management
      "Super+C".action = close-window;
      "Super+F".action = maximize-column;
      "Super+V".action = toggle-window-floating;
      "Super+M".action = quit;
      "Super+L".action = spawn "hyprlock";

      # Navigation (Essential for Niri's horizontal strip)
      "Super+Left".action = focus-column-left;
      "Super+Right".action = focus-column-right;
      "Super+Shift+Left".action = move-column-left;
      "Super+Shift+Right".action = move-column-right;

      # Workspaces (Vertical)
      "Super+1".action = focus-workspace 1;
      "Super+2".action = focus-workspace 2;
      "Super+3".action = focus-workspace 3;
      "Super+4".action = focus-workspace 4;
      "Super+5".action = focus-workspace 5;
      "Super+6".action = focus-workspace 6;
      "Super+7".action = focus-workspace 7;
      "Super+8".action = focus-workspace 8;
      "Super+9".action = focus-workspace 9;
      "Super+0".action = focus-workspace 10;

      "Super+Shift+1".action = move-window-to-workspace 1;
      "Super+Shift+2".action = move-window-to-workspace 2;
      "Super+Shift+3".action = move-window-to-workspace 3;
      "Super+Shift+4".action = move-window-to-workspace 4;
      "Super+Shift+5".action = move-window-to-workspace 5;
      "Super+Shift+6".action = move-window-to-workspace 6;
      "Super+Shift+7".action = move-window-to-workspace 7;
      "Super+Shift+8".action = move-window-to-workspace 8;
      "Super+Shift+9".action = move-window-to-workspace 9;
      "Super+Shift+0".action = move-window-to-workspace 10;

      # Utilities
      "Super+Shift+S".action = spawn "hyprshot" "--clipboard-only" "-m" "region";
      "Super+Shift+C".action = spawn "hyprpicker" "-a";
    };

    # Startup Applications
    spawn-at-startup = [
      {command = ["waybar"];}
      {command = ["hyprpaper"];}
      {command = ["vicinae" "server"];}
    ];

    # Environment
    environment = {
      "HYPRCURSOR_THEME" = "rose-pine-hyprcursor";
    };
  };
}

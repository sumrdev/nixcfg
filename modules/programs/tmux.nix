{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-space";
    plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
        '';
      }
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g status-position top
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };
}

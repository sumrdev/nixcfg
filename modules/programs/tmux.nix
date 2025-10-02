{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-space";
    plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      kanagawa
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g status-position top
      set-window-option -g mode-keys vi
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };
}

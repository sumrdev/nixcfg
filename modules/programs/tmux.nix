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
      kanagawa
    ];
    extraConfig = ''
      set -g status-position top
      set-window-option -g mode-keys vi
      set -g default-terminal "tmux-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };
}

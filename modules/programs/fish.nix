{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      set EDITOR nvim
    '';
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}

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
      set -e WAYLAND_DISPLAY
    '';
    functions = {
      fish_prompt = {
        description = "Custom prompt showing the first three letters of the current directory, followed by a semicolon.";

        body = ''
          set current_dir (basename $PWD)

          set prompt_prefix (echo $current_dir | string sub -l 3)

          echo -n (set_color green)$prompt_prefix(set_color normal)'; '
        '';
      };
    };
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}

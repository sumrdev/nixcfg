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
    shellAbbrs = {
      j = "jj";
      jrt = "jj rebase -d 'trunk()' && jj simplify-parents";
      jri = "jj rebase -A 'trunk()' -B 'merge' -r";
    };
    functions = {
      fish_prompt = {
        description = "Custom prompt showing the first three letters of the current directory, followed by a semicolon.";

        body = ''
          set -l current_dir (basename $PWD)
          set -l prompt_prefix (echo $current_dir | string sub -l 3)

          # Check if we are in an SSH session
          if set -q SSH_TTY
              # Get the hostname (short version)
              set -l host (hostname -s)
              echo -n (set_color yellow)"($host) "
          end

          echo -n (set_color green)$prompt_prefix(set_color normal)'; '
        '';
      };
    };
    plugins = [
      {
        name = "jj";
        src = inputs.fish-plugin-jj;
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}

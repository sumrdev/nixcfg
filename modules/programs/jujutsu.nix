{
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) openssh git;
in {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "sumr";
        email = "foss@sumr.dk";
      };
      ui = {
        log-word-wrap = true;
        paginate = "never";
      };
      signing = {
        behavior = "drop";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        backends.ssh.program = "${openssh}/bin/ssh-keygen";
      };
      git = {
        sign-on-push = true;
        private-commits = ''
          description(glob-i:'wip:*') | description(glob-i:'ai:*')
        '';
        executable-path = "${getExe git}";
        track-default-bookmark-on-clone = true;
      };
    };
  };
}

{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) getExe;
  inherit (pkgs) openssh git;
in
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Marius Nielsen";
        email = "msn@uxvtechnologies.com";
      };
      ui = {
        log-word-wrap = true;
        paginate = "never";
        default-command = [
          "log"
          "--reversed"
        ];
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
      revset-aliases."immutable_heads()" = "builtin_immutable_heads() | (trunk().. & ~mine())";
      templates = {
        # template for showing diff during a jj describe
        # https://github.com/jj-vcs/jj/issues/1946#issuecomment-2561045057
        draft_commit_description = ''
          concat(
            coalesce(description, default_commit_description, "\n"),
            surround(
              "\nJJ: This commit contains the following changes:\n", "",
              indent("JJ:     ", diff.stat(72)),
            ),
            "\nJJ: ignore-rest\n",
            diff.git(),
          )
        '';
        # Names branches created by `jj git push -c` based on latest commit
        # message. Replaced all non-alphanumeric with -.
        # "feat(shopping): add the amazing button" ->
        # "feat/shopping-add-amazing-button"
        git_push_bookmark = ''
          description
            .first_line()
            .replace(
              regex:"[^a-zA-Z0-9]+",
              "-"
            )
            .replace(
              "-",
              "/",
              1
            )
        '';
      };
    };
  };
}

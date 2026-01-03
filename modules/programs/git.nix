{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "sumrdev";
      email = "git@sumr.dk";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}

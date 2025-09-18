{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "sumrdev";
    userEmail = "git@sumr.dk";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}

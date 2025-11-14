{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.git = {
    enable = true;
    userEmail = "git@sumr.dk";
    userName = "sumrdev";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}

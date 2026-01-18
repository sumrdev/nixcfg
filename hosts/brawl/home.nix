{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/programs/fish.nix
    ../../modules/programs/git.nix
    ../../modules/programs/jujutsu.nix
    ../../modules/programs/nvf/nvim.nix
    ../../modules/programs/tmux.nix
    ../../modules/programs/zoxide.nix
    ../../modules/services/tailscale.nix
    inputs.nvf.homeManagerModules.default
  ];
  home = {
    packages = with pkgs; [
      wget
      protonvpn-gui
      wireguard-tools
      ripgrep
      gowall
      vesktop
      jujutsu
      comma
      tree
      python3
      neovim
      nautilus
      openvpn
    ];

    username = "ms";
    homeDirectory = "/home/ms";

    stateVersion = "25.05";
  };
}

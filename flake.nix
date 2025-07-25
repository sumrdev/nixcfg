{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
    }:
    {
      nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };
    };
}

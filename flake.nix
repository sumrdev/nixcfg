{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pinix = {
      url = "github:remi-dupre/pinix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-wsl,
    zen-browser,
    rose-pine-hyprcursor,
    pinix,
    spicetify-nix,
    vicinae,
    nvf,
    self,
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      blackout = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/blackout/configuration.nix
        ];
        specialArgs = {
          inherit system inputs;
        };
      };
      starscream = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/starscream/configuration.nix
        ];
        specialArgs = {
          inherit system inputs;
        };
      };
      barricade = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/barricade/configuration.nix
        ];
        specialArgs = {
          inherit system inputs;
        };
      };
    };
  };
}

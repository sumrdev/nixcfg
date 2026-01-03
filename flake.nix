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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
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
    lanzaboote,
    self,
  } @ inputs: 
  {
    nixosConfigurations = {
      blackout = nixpkgs.lib.nixosSystem {
        modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./hosts/blackout/configuration.nix
          lanzaboote.nixosModules.lanzaboote
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      starscream = nixpkgs.lib.nixosSystem {
        modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./hosts/starscream/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      barricade = nixpkgs.lib.nixosSystem {
        modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./hosts/barricade/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}

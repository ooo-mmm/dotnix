{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Yazi file manager
    yazi.url = "github:sxyazi/yazi";

    # COSMIC Epoch
    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Stylix
    stylix.url = "github:danth/stylix";

    walls = {
      url = "github:ooo-mmm/wallpapers";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    yazi,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      bliss = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/bliss ];
      };
    };

    homeConfigurations = {
      "monk@bliss" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home/monk/home.nix
          catppuccin.homeManagerModules.catppuccin
          ({ pkgs, ... }: {
              home.packages = [ yazi.packages.${pkgs.system}.default ];
          })
          stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}

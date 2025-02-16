{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Yazi file manager
    # yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      # yazi,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      homeConfigurations = {
        "v" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home ];
        };
      };
    };
}

{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url =
      "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    # Yazi file manager
    yazi.url = "github:sxyazi/yazi";

    walls = {
      url = "github:ooo-mmm/wallpapers";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, yazi, ... }@inputs:
    let
      inherit (self) outputs;
      hosts = [ "pc" "lapi" ];
    in {
      nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit host inputs outputs; };
          modules = [ ./hosts/${host} ];
        };
      }) hosts);

      homeConfigurations = {
        "v" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home ];
        };
      };
    };
}

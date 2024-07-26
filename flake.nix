{
  description = "My NixOs Home :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, stylix, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
      	  ./hosts/default/configuration.nix
          home-manager.nixosModules.default
	  stylix.nixosModules.stylix
	  nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
        ];
      };
    };
}

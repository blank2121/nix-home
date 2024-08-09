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

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixvim.url = "github:blank2121/nixvim";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, stylix, nix-flatpak, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
	  nix-flatpak.nixosModules.nix-flatpak
	  nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
	  stylix.nixosModules.stylix
      	  ./hosts/default/configuration.nix
          home-manager.nixosModules.default
        ];
      };
    };
}

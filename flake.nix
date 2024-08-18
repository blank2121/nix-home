{
  description = "My NixOS Home :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    nixvim.url = "github:blank2121/nixvim";
    stylix.url = "github:danth/stylix";
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  # add lix-module
  outputs = { self, nixpkgs, nixos-hardware, home-manager, stylix, nix-flatpak, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
          home-manager.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
          stylix.nixosModules.stylix
          # lix-module.nixosModules.default
        ];
      };
    };
}

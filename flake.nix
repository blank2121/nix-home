{
  description = "My NixOS Home :)";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    nixvim.url = "path:/home/winston/nixvim/";
    polymc.url = "github:PolyMC/PolyMC";
    stylix.url = "github:danth/stylix";
    niri.url = "github:sodiboo/niri-flake";
    writer.url = "path:/home/winston/writer/";
  };

  outputs = { self, home-manager, polymc, niri,
  nixos-hardware, nixpkgs, stylix, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        config.allowBroken = true;
        nix.package = pkgs.nixVersions.unstable;
        overlays = [
          niri.overlays.niri
          polymc.overlay
        ];
      };
    in {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/main/configuration.nix
            ./hosts/main/hardware-configuration.nix
            home-manager.nixosModules.default
            niri.nixosModules.niri
            nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
            stylix.nixosModules.stylix
          ];
        };
      };
    };
}

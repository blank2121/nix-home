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
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    nixvim.url = "github:blank2121/nixvim";
    stylix.url = "github:danth/stylix";
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    niri.url = "github:sodiboo/niri-flake";
    writer.url = "path:/home/winston/writer/";
  };

  outputs = { self, home-manager, niri, nix-flatpak, 
  nixos-hardware, nixpkgs, stylix, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        overlays = [
          niri.overlays.niri
        ];
      };
    in {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/main/configuration.nix
            home-manager.nixosModules.default
            nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
            niri.nixosModules.niri
            stylix.nixosModules.stylix
            # lix-module.nixosModules.default
          ];
        };
      };
    };
}

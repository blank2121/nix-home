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
    niri.url = "github:sodiboo/niri-flake";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    nixvim.url = "github:blank2121/nixvim";
    polymc.url = "github:PolyMC/PolyMC";
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      home-manager,
      polymc,
      niri,
      nixos-hardware,
      nixpkgs,
      stylix,
      ...
    }@inputs:
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
    
      # variable definitions
      username = "winston";
      hostname = "main";
 
      # used modules
      mainFiles = [
        ./modules/nixos/audio.nix
        ./modules/nixos/nixvim.nix
        ./modules/nixos/style.nix
        ./modules/nixos/wm/niri.nix
        ./modules/nixos/wm/swaylock.nix
        ./modules/nixos/wm/swaync.nix
        ./modules/nixos/wm/waybar.nix
        ./modules/nixos/wm/wayland.nix
        ./modules/nixos/wm/wlogout.nix
      ];
    in
    {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs username hostname; };
          modules = mainFiles
            ++ [
              ./hosts/main/configuration.nix
              ./hosts/main/hardware-configuration.nix
              niri.nixosModules.niri
              nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
              stylix.nixosModules.stylix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager = {
                  backupFileExtension = "backup";
                  extraSpecialArgs = {
                    inherit inputs;
                    inherit username;
                  };
                  users.${username}.imports = [
                    ./hosts/main/home.nix
                    ./modules/home-manager/all.nix
                  ];
                };
              }
            ];
        };
        nmain = nixpkgs.lib.nixosSystem {
            inherit pkgs;
            # only supports single user
            specialArgs = { 
                inherit inputs;
                username = "winston";
                hostname = "main";
            }; 
            modules = [ 
                ./hosts/nmain 
                niri.nixosModules.niri
                nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
                stylix.nixosModules.stylix
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager = { backupFileExtension = "backup"; };
                }
            ];
        };
      };
    };
}

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
    nixvim.url = "path:/home/winston/nixvim/";
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
      zen-browser,
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
      username = "winston";
      hostname = "main";
      main = [
        ./modules/nixos/audio.nix
        # ./modules/nixos/games.nix
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
          specialArgs = { inherit inputs; };
          modules = main ++ [
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
            (
              { ... }:
              {
                nix.settings.experimental-features = "nix-command flakes";

                # Define a user account. Don't forget to set a password with ‘passwd’.
                programs.zsh.enable = true;
                users.users."${username}" = {
                  isNormalUser = true;
                  home = "/home/${username}";
                  extraGroups = [
                    "networkmanager"
                    "wheel"
                    "audio"
                  ];
                  hashedPassword = "$6$CDoyxcjZZ6zoPWqx$TkOnZ7WplwA7rlQS4crnnnlpX0uuNnssFfvOYk6dOB0T7Xr/SURq9o.3MT.eAiu0TxUfWW3ERlyvRp/L06ZiS.";
                  shell = pkgs.zsh;
                };

                networking.hostName = "${hostname}";
              }
            )
          ];
        };

        # other instances
      };
    };
}

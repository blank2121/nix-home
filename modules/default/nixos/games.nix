{ config, pkgs, lib, inputs, ... }:
let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "0pfn9fwjf6m83hk9z8nkmqrwcvd61abshbpw05v656vz5zx621ax";
  });
in
{
  imports = [
    aagl-gtk-on-nix.module
  ];

  # one off games/apps
  programs.honkers-railway-launcher.enable = true;

  # steam gaming

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPACT_TOOL_PATHS = "/home/winston/.steam/root/compatibilitytools.d";
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  
  environment.systemPackages = with pkgs; [
    mangohud
    protonup
    r2modman

    # emulators
    ryujinx
    melonDS
  ];

  programs.gamemode.enable = true;
}

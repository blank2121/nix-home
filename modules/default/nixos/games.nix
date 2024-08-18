{ config, pkgs, lib, inputs, ... }:
let
  #Honkai Star Rail
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "1mnsks7kibjr8kb1cjy2052kjaxrvfp5adg2ibfal7j9862042af";
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

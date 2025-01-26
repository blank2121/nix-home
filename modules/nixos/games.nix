{
  config,
  pkgs,
  lib,
  ...
}:
let
  #Honkai Star Rail
  aagl-gtk-on-nix = import (
    builtins.fetchTarball {
      url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
      sha256 = "0v59frhfnyy7pbmbv7bdzssdp554bjsgmmm4dw31p5askysmlvib";
    }
  );
in
{
  imports = [
    aagl-gtk-on-nix.module
  ];

      # one off games/apps
      # override for hsr to not install
      programs.honkers-railway-launcher.enable = false;

      # steam gaming

      environment.sessionVariables = {
        STEAM_EXTRA_COMPACT_TOOL_PATHS = "/home/winston/.steam/root/compatibilitytools.d";
      };

      programs.steam.enable = true;
      programs.steam.gamescopeSession.enable = true;

      # games + packages
      environment.systemPackages = with pkgs; [
              # games
              polymc

              # tools
              mangohud
              protonup
              r2modman

              # emulators
              ryujinx
              melonDS
            ];

      programs.gamemode.enable = true;
}

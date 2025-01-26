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
  options = {
    games.enable = lib.mkOption {
      default = false;
    };
  };

  imports = [
    aagl-gtk-on-nix.module
  ];

  config =
    let
      on = config.games.enable;
    in
    {

      # one off games/apps
      # override for hsr to not install
      programs.honkers-railway-launcher.enable = on && false;

      # steam gaming

      environment.sessionVariables = {
        STEAM_EXTRA_COMPACT_TOOL_PATHS = "/home/winston/.steam/root/compatibilitytools.d";
      };

      programs.steam.enable = on;
      programs.steam.gamescopeSession.enable = on;

      # games + packages
      environment.systemPackages =
        with pkgs;
        (
          if on then
            [
              # games
              polymc

              # tools
              mangohud
              protonup
              r2modman

              # emulators
              ryujinx
              melonDS
            ]
          else
            [ ]
        );

      programs.gamemode.enable = on;
    };
}

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
      sha256 = "1v9jk4j0zylx3ixwk5q8z22v6ir86pk9lfbf5q3ibgaggpf8kqa7";
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
      programs.honkers-railway-launcher.enable = on;

      # steam gaming

      environment.sessionVariables = {
        STEAM_EXTRA_COMPACT_TOOL_PATHS = "/home/winston/.steam/root/compatibilitytools.d";
      };

      programs.steam.enable = on;
      programs.steam.gamescopeSession.enable = on;

      environment.systemPackages =
        with pkgs;
        (
          if on then
            [
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

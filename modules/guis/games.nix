{
  config,
  lib,
  pkgs,
  username ? "winston",
  ...
}:
let
  #Honkai Star Rail
  # aagl-gtk-on-nix = import (
  #   builtins.fetchTarball {
  #     url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
  #     sha256 = "0f59radafvzdfn3ar1y6glx9ixc9hbvysaalsp492ixp8ihpkbxv";
  #   }
  # );
in
{
  # imports = [
  #   aagl-gtk-on-nix.module
  # ];

  options = {
    guis.games.enable = lib.mkEnableOption "game applications";
  };

  config = lib.mkIf config.guis.games.enable {

    # one off games/apps
    # programs.honkers-railway-launcher.enable = true;

    # steam gaming
    programs.steam = {
      dedicatedServer.openFirewall = true;
      enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
    };

    environment.sessionVariables = {
      STEAM_EXTRA_COMPACT_TOOL_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    # games + packages
    environment.systemPackages = with pkgs; [
      # games
      # polymc

      # tools
      mangohud
      protonup
      # r2modman

      # emulators
      # ryujinx
      # melonDS
    ];
  };
}

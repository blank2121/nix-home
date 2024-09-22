{ config, pkgs, lib, inputs, ... }:
let
  #Honkai Star Rail
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "023yqdxs83cxx39kl7cawwyr39c1qnnv4n99igpsm2a5yay3wmsa";
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

 {
  config,
  inputs,
  lib,
  pkgs,
  username ? "default",
  ...
}: let

godotpkgs = import (builtins.fetchGit {
  name = "godot_4";
  url = "https://github.com/NixOS/nixpkgs/";
  ref = "refs/heads/nixpkgs-unstable";
  allRefs = true;
  rev = "04dfd1b4f009eaf0c9753a1267864057800afc92";
}) { };

in {

  imports = [ ./games.nix ];

  options = {
    guis.enable = lib.mkEnableOption "gui applications";
  };

  config = lib.mkIf config.guis.enable {
      home-manager.users.${username} = {
          home.packages = with pkgs; [
            # morgen
            brightnessctl
            firefox
            inputs.zen-browser.packages."${pkgs.system}".default
            krita
            libreoffice
            mpv
            halftone
            gthumb
            gimp
            obsidian
            remnote
            spotify
            thunderbird-128
            tor-browser
            ueberzugpp
            discord
            winetricks
            zoom-us
          ] ++ [ godotpkgs.godot_4 ];

          programs.kitty = {
            enable = true;
            settings = {
              enable_audio_bell = false;
            };
            extraConfig = ''
              background_opacity 0.85
            '';
          };
      }; 
  };
}

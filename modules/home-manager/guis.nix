{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  godotpkgs = import (builtins.fetchGit {
    name = "godot_4";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    allRefs = true;
    rev = "04dfd1b4f009eaf0c9753a1267864057800afc92";
  }) { };
in
{
  home.packages =
    with pkgs;
    [
      # morgen
      inputs.zen-browser.packages."${pkgs.system}".default
      brightnessctl
      firefox
      foliate
      komikku
      krita
      libreoffice
      mpv
      obsidian
      remnote
      spotify
      thunderbird-128
      tor-browser
      ueberzugpp
      vesktop
      winetricks
    ]
    ++ [ godotpkgs.godot_4 ];

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
    };
    extraConfig = ''
      background_opacity 0.85
    '';
  };
}

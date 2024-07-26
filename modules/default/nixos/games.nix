{ config, pkgs, ... }:
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

  programs.honkers-railway-launcher.enable = true;
}

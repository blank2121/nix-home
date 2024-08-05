{ config, pkgs, ... }:

{
  imports = [
    ./apps/waybar.nix
  ];

  home.packages = with pkgs; [
    swww
    waybar
    wineWowPackages.waylandFull
    wl-clipboard
    wlogout
  ];

  home.file.hyprland = {
    enable = true;
    recursive = true;
    source = ../../../../dotfiles/.config/hypr;
    target = ".config/hypr/";
  };
}

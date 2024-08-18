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

  # home.file.".config/hypr/hyprland.conf".source = ../../../../dotfiles/.config/hypr/hyprland.conf;
}

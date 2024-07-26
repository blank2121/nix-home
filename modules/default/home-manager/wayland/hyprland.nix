{ config, pkgs, ... }:

{
  imports = [
    ./apps/waybar.nix
  ];

  home.packages = with pkgs; [
    rofi-wayland
    swww
    waybar
    wineWowPackages.waylandFull
    wl-clipboard
    wlogout
  ];

  home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

  # outdated for config
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ~/myHome/dotfiles/.config/hypr/hyprland.conf;
}

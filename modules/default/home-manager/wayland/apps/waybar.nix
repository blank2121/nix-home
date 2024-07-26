{ config, pkgs, ... }:

{
  home.file."waybar" = {
    enable = true;
    recursive = true;
    source = ../../../../../dotfiles/.config/waybar;
    target = ".config/waybar/";
  };
}

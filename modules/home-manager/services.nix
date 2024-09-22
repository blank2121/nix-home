{config, pkgs, ...}:

{
  services.dunst = {
    enable = true;
    configFile = "../../../dotfiles/.config/dunst/dunstrc";
  };
}

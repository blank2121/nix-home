{config, pkgs, ...}:
{
  # non-display server depended services
  services.dunst = {
    enable = true;
    configFile = "../../../dotfiles/.config/dunst/dunstrc";
  };
}

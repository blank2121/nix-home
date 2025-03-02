{ pkgs, ... }:
{
  home-manager.users.winston.services.swaync = {
    enable = true;
    settings = { };
    style = '''';
  };
  home-manager.users.winston.home.packages = with pkgs; [
    swaynotificationcenter
    libnotify
  ];
  home-manager.users.winston.services.batsignal.enable = true;
}

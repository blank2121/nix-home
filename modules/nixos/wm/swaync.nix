{ pkgs, ... }:
{
    home-manager.users.winston.services.swaync = {
        enable = true;
        settings = {};
        style = '''';
    };
    home-manager.users.winston.home.packages = with pkgs; [
        swaynotificationcenter
        libnotify
    ];
}

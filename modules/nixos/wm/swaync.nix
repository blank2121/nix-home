{
  username ? "winston",
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
      services.swaync = {
        enable = true;
        settings = { };
        style = '''';
      };
      services.batsignal.enable = true;

      home.packages = with pkgs; [
        swaynotificationcenter
        libnotify
      ];
  };
}

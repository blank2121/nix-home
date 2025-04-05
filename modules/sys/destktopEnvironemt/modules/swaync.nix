{
  config,
  lib,
  pkgs,
  username ? "winston",
  ...
}:
{

  options = {
    sys.desktopEnvironment.modules.swaync.enable = lib.mkEnableOption "swaync";
  };

  config = lib.mkIf config.sys.desktopEnvironment.modules.swaync.enable {
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
  };
}

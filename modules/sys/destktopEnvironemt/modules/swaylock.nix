{
  config,
  lib,
  username ? "winston",
  ...
}:
{
  options = {
    sys.desktopEnvironment.modules.swaylock.enable = lib.mkEnableOption "swaylock";
  };

  config = lib.mkIf config.sys.desktopEnvironment.modules.swaylock.enable {
      home-manager.users.${username}.programs.swaylock = {
          enable = true;
          settings = {
              indicator-idle-visible = false;
              indicator-radius = 100;
              show-failed-attempts = true;
          };
      };
  };
}

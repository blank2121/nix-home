{
  config,
  lib,
  username ? "winston",
  ...
}:
{
  options = {
    sys.desktopEnvironment.modules.wlogout.enable = lib.mkEnableOption "wlogout";
  };

  config = lib.mkIf config.sys.desktopEnvironment.modules.wlogout.enable {
      home-manager.users.${username}.programs.wlogout = {
          enable = true;
          style = ''
              window {
                  background-color: rgba(129, 51, 184, 0.1);
              }
          '';
      };
  };
}

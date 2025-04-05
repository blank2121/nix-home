{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    sys.desktopEnvironment.gnome.enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf config.sys.desktopEnvironment.gnome.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}

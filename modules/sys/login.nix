{
  config,
  lib,
  ...
}:
{
  options = {
    sys.login.ly.enable = lib.mkEnableOption "ly login";
    sys.login.sddm.enable = lib.mkEnableOption "sddm login";
  };

  config = {
    services.displayManager.ly.enable = config.sys.login.ly.enable;
    services.displayManager.sddm = {
      enable = config.sys.login.sddm.enable;
      wayland.enable = true;
      enableHidpi = true;
    };
  };
}

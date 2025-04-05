{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us,es";
    xkb.options = "grp:win_space_toggle";
    # xkb.extraLayouts = {
    #     "graphite" = {
    #
    #     };
    # };
    xkb.variant = "";
    screenSection = ''
      Option "UseEdid" "false"
      Option "PreferredMode" "2560x1600"
    '';
  };
  # desktop environment
  services.xserver.displayManager.gnome.enable = true;
}

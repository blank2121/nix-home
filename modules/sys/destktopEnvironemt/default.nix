{
  config,
  lib,
  ...
}: let

xdim = builtins.toString config.sys.desktopEnvironment.screenSize.x;
ydim = builtins.toString config.sys.desktopEnvironment.screenSize.y;

in {
  options = {
      sys.desktopEnvironment.screenSize = {
          x = lib.mkOption {
              type = lib.types.int;
              default = 2560;
              description = "Specify x dimention of screen.";
          };
          y = lib.mkOption {
              type = lib.types.int;
              default = 1600;
              description = "Specify y dimention of screen.";
          };
      };
  };
    imports = [ ./gnome.nix ./hyprland.nix ./niri.nix ./modules ];

    config = {
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
          Option "PreferredMode" "${xdim}x${ydim}"
        ''; 
      };

    };
}

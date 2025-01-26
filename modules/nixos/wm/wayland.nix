{ config, lib, ... }:
{
  imports = [
    ./swaylock.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
  ];


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
      videoDrivers = [ "amdgpu" ]; # Use "modesetting" driver
      screenSection = ''
        Option "UseEdid" "false"
        Option "PreferredMode" "2560x1600"
      '';
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
    };
}

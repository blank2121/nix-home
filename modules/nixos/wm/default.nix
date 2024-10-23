{ config, lib, ... }:
{
    imports = [
        ./niri.nix
        ./hyprland.nix

        # wayland shared utils

        # add it so when wayland is disabled, these are not loaded
        ./wlogout.nix
        ./swaylock.nix
        ./swaync.nix
    ];

    options = {
        wayland.enable = lib.mkOption {
            default = true;
        };
    };

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
            videoDrivers = [ "amdgpu" ]; # Use "modesetting" driver
            screenSection = ''
                Option "UseEdid" "false"
                Option "PreferredMode" "2560x1600"
            '';
        };

        services.displayManager.sddm = {
            enable = true;
            wayland.enable = config.wayland.enable;
            enableHidpi = true;
        };
    };
}

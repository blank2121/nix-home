{ config, pkgs, lib, ... }:
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
    videoDrivers = [ "nvidia" ]; # Use "modesetting" driver
    screenSection = ''
      Option "UseEdid" "false"
      Option "PreferredMode" "2560x1600"
    '';
  };

  hardware.graphics.enable = true;

  # nvidia only

  hardware.nvidia = { 
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    open = true;
    # package = "config.boot.kernelPackages.nvidiaPackages.legacy_470";
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    "Nvreg_EnableGpuFirmware=0"
  ];

  # desktop environment
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
    wayland-utils
    kdePackages.plasma-desktop
    kdePackages.plasma-wayland-protocols
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
  };
}

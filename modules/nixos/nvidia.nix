{ config, ... }:
{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = { 
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    "Nvreg_EnableGpuFirmware=0"
  ];
}

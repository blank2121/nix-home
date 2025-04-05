{
  config,
  lib,
  pkgs,
  username ? "default",
  ...
}:
{
  options = {
    sys.gpu = {
      nvidia.enable = lib.mkEnableOption "nvidia gpu";
      amd.enable = lib.mkEnableOption "amd gpu";
    };
  };

  config = {
      hardware = {
        graphics = {
          enable = config.sys.gpu.nvidia.enable || config.sys.gpu.amd.enable;
          enable32Bit = config.sys.gpu.amd.enable;
        };

        amdgpu.amdvlk = lib.mkIf config.sys.gpu.nvidia.enable {
          enable = true;
          support32Bit.enable = true;
        };
      };

      services.xserver.videoDrivers = if config.sys.gpu.nvidia.enable then [ "nvidia" ] else [ "amdgpu" ];

      hardware.nvidia = lib.mkIf config.sys.gpu.nvidia.enable {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      boot.kernelParams = lib.mkIf config.sys.gpu.nvidia.enable [
        "nvidia-drm.fbdev=1"
        "Nvreg_EnableGpuFirmware=0"
      ];
  };
}

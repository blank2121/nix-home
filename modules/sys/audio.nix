{
  config,
  inputs,
  lib,
  pkgs,
  username ? "default",
  ...
}:
{

  options = {
    sys.audio.enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf config.sys.audio.enable {
    # Enable audio
    services = {
      pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
        alsa-utils
    ];
  };
}

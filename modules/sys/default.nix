{
  config,
  lib,
  hostname ? "winston",
  ...
}:
{

  imports = [
    ./audio.nix
    ./battery.nix
    ./destktopEnvironemt
    ./gpu.nix
    ./login.nix
    ./stylix.nix
  ]; 

  options = {
    sys = {
        extraHosts = lib.mkOption {
            type = lib.types.string;
            default = '''';
            description = "Spot to add custom host connections.";
        };
        timeZone = lib.mkOption {
            type = lib.types.string;
            default = "";
            description = "Specify time-zone.";
        };
    };
  };

  config = {
    networking.extraHosts = config.sys.extraHosts;
    time.timeZone = config.sys.timeZone;
  };
}

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
    sys.battery = {
        enable = lib.mkEnableOption "battery";
        chargeMin = lib.mkOption {
            type = lib.types.int;
            default = 0;
            description = "Whether to enable tlp battery.";
        };
        chargeMax = lib.mkOption {
            type = lib.types.int;
            default = 100;
            description = "Whether to enable tlp battery.";
        };
    };
  };

  config = lib.mkIf config.sys.battery.enable {
    services.tlp = {
      enable = config.sys.battery.enable;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = config.sys.battery.chargeMin; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = config.sys.battery.chargeMax; # 85 and above it stops charging
      };
    };
  };
}

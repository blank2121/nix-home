{
  username ? "winston",
  hostname ? "main",
  pkgs,
  ...
}:
{

  nix.settings.experimental-features = "nix-command flakes";

  # user definition
  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    hashedPassword = "$6$CDoyxcjZZ6zoPWqx$TkOnZ7WplwA7rlQS4crnnnlpX0uuNnssFfvOYk6dOB0T7Xr/SURq9o.3MT.eAiu0TxUfWW3ERlyvRp/L06ZiS.";
    shell = pkgs.zsh;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # bluetooth setup
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable networking
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    bash
  ];

  programs.zsh.enable = true;

  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
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
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 85; # 85 and above it stops charging
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}

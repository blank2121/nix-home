{ config, pkgs, lib, inputs, ... }:
let
  dir = ../../modules/nixos;
  nixFiles = builtins.filter (file: 
    file != "flatpaks.nix" && # to ignore files
    file != "games.nix" &&
    builtins.match ".*\\.nix" file != null) 
    (builtins.attrNames (builtins.readDir dir));
  imps = map (file: import "${dir}/${file}") nixFiles ++ [ ./hardware-configuration.nix ];
in {
  imports = imps;

  nix.settings.experimental-features = "nix-command flakes";

  # home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { 
      inherit inputs;
    };
    users."winston" = import ./home.nix;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "main"; # Define your hostname.
  networking.extraHosts = ''
    0.0.0.0 log-upload-os.hoyoverse.com
    0.0.0.0 sg-public-data-api.hoyoverse.com
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # bluetooth setup
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us,es";
    xkb.options = "grp:win_space_toggle";
    xkb.variant = "";
    videoDrivers = [ "amdgpu" ]; # Use "modesetting" driver
    screenSection = ''
      Option "UseEdid" "false"
      Option "PreferredMode" "2560x1600"
    '';
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.desktopManager.budgie.enable = true;
  environment.budgie.excludePackages = with pkgs; [
    mate.mate-calc
    vlc
    mate.pluma
    mate.eom
    mate.engrampa
    mate.atril
    gnome.rygel
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.winston = {
    isNormalUser = true;
    description = "winston";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    bash
  ];

  # nh configuration
  programs.nh = {
    enable = true;
    flake = "/home/winston/myHome";
  };

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
       STOP_CHARGE_THRESH_BAT0 = 85; # 78 and above it stops charging
      };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

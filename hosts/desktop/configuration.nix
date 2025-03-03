{ config, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.extraHosts = ''
    0.0.0.0 log-upload-os.hoyoverse.com
    0.0.0.0 sg-public-data-api.hoyoverse.com
  '';

  # bluetooth setup: NO BLUETOOTH ON CURRENT DESKTOP
  # hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.blueman.enable = true;


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

  environment.systemPackages = with pkgs; [
    bash
  ];

  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

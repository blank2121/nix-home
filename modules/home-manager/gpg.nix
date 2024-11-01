{ config, pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableExtraSocket = true;
    enableSshSupport = true;
  };
}

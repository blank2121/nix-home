{ config, pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableExtraSocket = true;
    enableSshSupport = true;
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = config.home.homeDirectory + "/nixcfg/gpg-key/subkey.pub";
        trust = 5;
      }
    ];
  };
}

{ username ? "winston", pkgs, ... }:
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
        source = "/home/${username}/nixcfg/gpg-key/subkey.pub";
        trust = 5;
      }
    ];
  };
}

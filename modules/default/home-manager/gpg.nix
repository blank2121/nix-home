{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    publicKeys = [
      { source = ../../../gpg-key/subkey.pub; }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
  };
}

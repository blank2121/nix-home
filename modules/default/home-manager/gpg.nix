{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        text = builtins.readFile "${config.home.homeDirectory}/myHome/gpg-key/subkey.pub";
	trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
  };
}

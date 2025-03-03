{ config, username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nv";
      NIXOS_OZONE_WL = "1";
      OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };

  programs = {
    eza = {
      enable = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = false;
    };

    home-manager.enable = true;

    ripgrep.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

{ config, pkgs, ... }:

{

  imports = [
    ../../modules/default/home-manager/clis-apps.nix
    ../../modules/default/home-manager/file-viewer.nix
    ../../modules/default/home-manager/git.nix
    ../../modules/default/home-manager/gpg.nix
    ../../modules/default/home-manager/python-pkgs.nix
    ../../modules/default/home-manager/services.nix
    ../../modules/default/home-manager/sh.nix
    ../../modules/default/home-manager/wayland/hyprland.nix
    ../../modules/default/home-manager/zellij.nix
  ];
  home = {
    username = "winston";
    homeDirectory = "/home/winston";

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
      icons = true;
      enableNushellIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = false;
    };

    home-manager.enable = true;

    password-store.enable = true; 

    ripgrep.enable = true;

    starship = {
      enable = true;
      #enableNushellIntegration = true;
    };

    thefuck = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      #enableNushellIntegration = true;
    };
  };
}

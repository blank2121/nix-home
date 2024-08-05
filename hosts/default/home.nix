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

    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "nv";
      NIXOS_OZONE_WL = "1";
      OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };

  programs = {
    bacon.enable = true;
    bat.enable = true;
    bottom.enable = true;

    eza = {
      enable = true;
      icons = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    home-manager.enable = true;

    # do declaritively
    # lf = {
    #   enable = true;
    #   extraConfig = builtins.readFile "${config.home.homeDirectory}/myHome/dotfiles/.config/lf/lfrc";
    # };

    password-store.enable = true; 

    ripgrep.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    thefuck = {
      enable = true;
      enableInstantMode = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

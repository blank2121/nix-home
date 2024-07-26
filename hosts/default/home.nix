{ config, pkgs, ... }:

{

  imports = [
    ../../modules/default/home-manager/gpg.nix
    ../../modules/default/home-manager/clis-apps.nix
    ../../modules/default/home-manager/python-pkgs.nix
    ../../modules/default/home-manager/services.nix
    ../../modules/default/home-manager/sh.nix
    ../../modules/default/home-manager/wayland/hyprland.nix
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

    gh.enable = true;
    gitui.enable = true;
    home-manager.enable = true;

    # do declaritively
    lf = {
      enable = true;
      extraConfig = builtins.readFile ~/myHome/dotfiles/.config/lf/lfrc;
    };

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

    zellij = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  # home.file conf
  home.file."starship.toml" = {
    enable = true;
    source = ../../dotfiles/.config/starship.toml;
    target = ".config/starship.toml";
  };
}

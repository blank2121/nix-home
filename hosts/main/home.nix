{ config, pkgs, ... }:
let
  nixFiles = builtins.filter (file: 
    builtins.match ".*\\.nix" file != null) 
    (builtins.attrNames (builtins.readDir ../../modules/main/home-manager));
  imports = map (file: import ./${file}) nixFiles;
in {
  inherit imports;
  # imports = [
  #   ../../modules/main/home-manager/clis-apps.nix
  #   ../../modules/main/home-manager/file-viewer.nix
  #   ../../modules/main/home-manager/git.nix
  #   ../../modules/main/home-manager/gpg.nix
  #   ../../modules/main/home-manager/python-pkgs.nix
  #   ../../modules/main/home-manager/services.nix
  #   ../../modules/main/home-manager/sh.nix
  #   ../../modules/main/home-manager/hyprland.nix
  #   ../../modules/main/home-manager/zellij.nix
  #   ../../modules/main/home-manager/pass-store.nix
  # ];
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

    ripgrep.enable = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
    };

    thefuck = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}

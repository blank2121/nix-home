{ config, lib, ... }:
let
  dir = ../../modules/main/home-manager;
  nixFiles = builtins.filter (file: 
    # file != "hyprland.nix" &&
    builtins.match ".*\\.nix" file != null) 
    (builtins.attrNames (builtins.readDir dir));
  imps = map (file: import "${dir}/${file}") nixFiles;
in {
  imports = imps;

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

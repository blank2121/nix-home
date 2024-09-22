{ inputs, ... }:
let
  dir = ../../modules/home-manager;
  nixFiles = builtins.filter (file: 
    # (isHyprland || file != "hyprland.nix") &&
    file != "games.nix" &&
    builtins.match ".*\\.nix" file != null) 
    (builtins.attrNames (builtins.readDir dir));
  imports = map (file: import "${dir}/${file}") nixFiles;
in {
  inherit imports;

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

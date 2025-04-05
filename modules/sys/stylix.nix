{
  config,
  lib,
  pkgs,
  username ? "winston",
  ...
}:
let
  coffeeOG = {
    base00 = "#160f0a";
    base01 = "#281b12";
    base02 = "#312217";
    base03 = "#6e6a86";
    base04 = "#908caa";
    base05 = "#efded1";
    base06 = "#efded1";
    base07 = "#524f67";
    base08 = "#eb6f92";
    base09 = "#f6c177";
    base0A = "#ebbcba";
    base0B = "#31748f";
    base0C = "#9ccfd8";
    base0D = "#c4a7e7";
    base0E = "#f6c177";
    base0F = "#524f67";
  };
  coffeeFall = {
    base00 = "#3e2f2c";
    base01 = "#6a4e44";
    base02 = "#b04a3a";
    base03 = "#8a6340";
    base04 = "#d0a362";
    base05 = "#e8d8c3";
    base06 = "#a77c71";
    base07 = "#ffffff";
    base08 = "#b04a3a";
    base09 = "#d76955";
    base0A = "#b47b57";
    base0B = "#e8c79e";
    base0C = "#7c5c51";
    base0D = "#9e6d4c";
    base0E = "#5b4539";
    base0F = "#7f6053";
  };

# lib.mkEnableOption but with default = true;
boolOption = (name:
    lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
});

in {

  options = {
    sys.stylix.enable = boolOption "stylix";
  };

  config = lib.mkIf config.sys.stylix.enable {
    stylix.enable = true;
    stylix.polarity = "dark";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    #rose-pine, gruvbox-dark-soft
    stylix.image = ../sytlix.png;

    # cursor
    stylix.cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };

    # fonts
    stylix.fonts = {
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.fira-code-symbols;
        name = "Fira Code Symbol";
      };
    };

    stylix.fonts.sizes = {
      applications = 12;
      desktop = 12;
      popups = 12;
      terminal = 14;
    };

    # other general fonts

    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        hinting.autohint = true;
        hinting.enable = true;
        # defaultFonts = {
        #   serif = [ "JetBrainsMono Nerd Font" ];
        #   sansSerif = [ "JetBrainsMono Nerd Font" ];
        #   monospace = [ "JetBrainsMono Nerd Font" ];
        #   emoji = [ "Fira Code Symbol" ];
        # };
      };
          
      packages = with pkgs; [
        ubuntu_font_family
        # Persian Font
        vazir-fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.jetbrains-mono
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        liberation_ttf
        google-fonts
      ];
    };

    # weird qt error even tho qt is not used at all
    stylix.targets.qt.platform = "qtct";
  };
}

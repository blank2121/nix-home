{config, lib, pkgs, inputs, ...}:

{
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
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
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
      name = "JetBrainsMono Nerd Font";
    };

    sansSerif = {
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
      name = "JetBrainsMono Nerd Font";
    };

    monospace = {
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
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
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];
  };
}

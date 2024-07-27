{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    angryipscanner
    brightnessctl
    btrfs-progs
    fd
    firefox
    flatpak
    fzf
    gcc
    gh
    ghc
    git
    gitui
    glow
    gnumake
    gnupg
    godot_4
    gum
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server
    hplip
    jq
    julia
    mark
    mprocs
    mpv

    nmap
    nodejs_20
    #ntfy
    openjdk
    openssl_3
    pandoc
    pango
    pass
    poetry
    python312Full
    # remnote
    ripgrep
    rustup
    # spotify
    texliveFull
    tor-browser
    trash-cli
    ueberzugpp
    vim
    wget
    which
    winetricks
    ansel
  ];

  # apps
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
    };
    extraConfig = ''
      background_opacity 0.85
    '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "run,drun,window";
      "icon-theme" = "Oranchelo";
      "show-icons" = true; 
      terminal = "kitty";
      "drun-display-format" = "{icon} {name}";
      "location" = 0;
      "disable-history" = false;
      "hide-scrollbar" = true;
      "display-drun" = "   Apps ";
      "display-run" = "   Run ";
      "display-window" = " 﩯  Window";
      "display-Network" = " 󰤨  Network";
      "sidebar-mode" = true;
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      # theme = "base16_default";
      editor = {
        line-number = "relative";
        
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      }; 
    };
    extraPackages = with pkgs; [
      rust-analyzer
      marksman
    ];
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = ../../../dotfiles/.config/zellij;
    };
  };

  programs.eww = {
    enable = true;
    configDir = ../../../dotfiles/.config/eww;
  };
}

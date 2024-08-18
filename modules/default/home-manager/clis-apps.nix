{ config, pkgs, lib, ... }:

{
  # allowing unfree apps
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
    "remnote"
    "spotify"
  ];

  home.packages = with pkgs; [
    #ntfy
    # ansel
    bacon
    bat
    bottom
    brightnessctl
    btrfs-progs
    fd
    firefox
    fzf
    gcc
    gh
    ghc
    glow
    gnumake
    gnupg
    godot_4
    gum
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server
    hplip
    jan
    jq
    julia
    komikku
    libreoffice
    mark
    mprocs
    mpv
    nmap
    nodejs_20
    obsidian
    openjdk
    openssl_3
    pandoc
    pango
    pass
    poetry
    python312Full
    remnote
    ripgrep
    rustup
    spotify
    texliveFull
    thunderbird-128
    tor-browser
    trash-cli
    # ueberzugpp
    ueberzug

    vesktop
    vim
    wget
    which
    winetricks
    wireshark
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
      "display-window" = " 󱇙  Window";
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
}

{ config, pkgs, lib, ... }:
let
     zugpppkgs = import (builtins.fetchGit {
         name = "ueberzugpp";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixpkgs-unstable";
         rev = "0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb";
     }) {};

     godotpkgs = import (builtins.fetchGit {
         name = "godot_4";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixpkgs-unstable";
         allRefs = true;
         rev = "04dfd1b4f009eaf0c9753a1267864057800afc92";
     }) {};

     # ueberzugpp = zugpppkgs.ueberzugpp;
     godot_43-stable = godotpkgs.godot_4;
     
in {
  # allowing unfree apps
  nixpkgs.config = { 
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ 
      "obsidian"
      "remnote"
      "morgen"
      "spotify"
    ] ++ [godotpkgs.godot_4.getName];
  };

  home.packages = with pkgs; [
    # ntfy
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
    gum
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server
    hplip
    jan
    jq
    julia
    komikku
    krita
    libreoffice
    mark
    morgen
    mprocs
    mpv
    nh
    nix-output-monitor
    nmap
    nodejs_20
    obsidian
    openjdk
    openssl_3
    pandoc
    pango
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
    ueberzugpp
    vesktop
    vim
    wget
    which
    winetricks
    wireshark
  ] ++ [ godot_43-stable ];

  # apps

  # ERROR: currently broken
  # programs.kitty = {
  #   enable = true;
  #   settings = {
  #     enable_audio_bell = false;
  #   };
  #   extraConfig = ''
  #     background_opacity 0.85
  #   '';
  # };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "run,drun,window";
      "icon-theme" = "Oranchelo";
      "show-icons" = true; 
      terminal = "foot";
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

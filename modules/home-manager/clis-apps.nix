{
  config,
  pkgs,
  lib,
  ...
}:
let
  godotpkgs = import (builtins.fetchGit {
    name = "godot_4";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    allRefs = true;
    rev = "04dfd1b4f009eaf0c9753a1267864057800afc92";
  }) { };
  gui-apps =
    with pkgs;
    [
      wireshark
      winetricks
      vesktop
      ueberzugpp
      tor-browser
      thunderbird-128
      spotify
      remnote
      obsidian
      mpv
      morgen
      libreoffice
      krita
      komikku
      jan
      foliate
      firefox
      brightnessctl
    ]
    ++ [ godotpkgs.godot_4 ];
in
{
  options = {
    gui.enable = lib.mkOption {
      default = true;
      description = ''
        weather to enable any apps or clis that use guis
      '';
    };
  };
  config = {
    home.packages =
      with pkgs;
      [
        # ntfy
        # ansel
        bacon
        bat
        bottom
        btrfs-progs
        fd
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
        jq
        julia
        mark
        mprocs
        nix-output-monitor
        nmap
        nodejs_20
        openjdk
        openssl_3
        pandoc
        pango
        poetry
        python312Full
        ripgrep-all
        rustup
        texliveFull
        trash-cli
        vim
        wget
        which
      ]
      ++ (if config.gui.enable then gui-apps else [ ]);

    # apps
    programs.kitty = {
      enable = config.gui.enable;
      settings = {
        enable_audio_bell = false;
      };
      extraConfig = ''
        background_opacity 0.85
      '';
    };

    programs.rofi = {
      enable = config.gui.enable;

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
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
      extraPackages = with pkgs; [
        rust-analyzer
        marksman
      ];
    };
  };
}

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
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      enable_audio_bell = false;
      include = "~/dotfiles/.config/kitty/themes/Decay-Green.conf";
    };
    extraConfig = ''
      background_opacity 0.85
    '';
  };

  home.file."rofi" = {
    enable = true;
    source = ../../../dotfiles/.config/rofi/config.rasi;
    target = ".config/rofi/config.rasi";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_default";
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

  home.file."zellij" = {
    enable = true;
    recursive = true;
    source = ../../../dotfiles/.config/zellij;
    target = ".config/zellij/";
  };

  programs.eww = {
    enable = true;
    configDir = ../../../dotfiles/.config/eww;
  };
}

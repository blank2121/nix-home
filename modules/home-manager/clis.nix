{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # ntfy
    # ansel
    bacon
    bat
    btop
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
    haskellPackages.stack
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
  ];

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
}

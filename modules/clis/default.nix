{ 
    config,
    inputs,
    lib,
    pkgs,
    username ? "default",
    ...
}: let 

# lib.mkEnableOption but with default = true;
boolOption = (name:
    lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
});

in {
    imports = [
        ./configurable.nix
        ./editors.nix
        ./sh.nix
    ];

    options = {
        clis.unconfigured.enable = boolOption "cli programs";
    };

    config = lib.mkIf config.clis.unconfigured.enable {

        home-manager.users.${username} = {
          # base setup for home-manager
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
          };

          # configureless CLIS with home-manager
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
            # mark
            mprocs
            nix-output-monitor
            nmap
            nodejs_20
            openjdk
            openssl_3
            pandoc
            pango
            ripgrep-all
            texliveFull
            trash-cli
            vim
            wget
            which
            
            cargo
            clippy
            rustfmt
            rust-analyzer
            rustc
          ];
        };
    };
}

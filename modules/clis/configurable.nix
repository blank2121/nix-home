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
    options = {
        clis.configurable = { 
            enable = boolOption "configurable clis";
            git.enable = boolOption "git";
            gpg.enable = boolOption "gpg";
            pass.enable = boolOption "pass-store";
            zellij.enable = boolOption "zellij";
        };
    };

    config = lib.mkIf config.clis.configurable.enable {
        home-manager.users.${username} = {

          # git
          programs.git = {
            enable = config.clis.configurable.git.enable;
            aliases = {
              a = "add";
              cm = "commit";
              co = "checkout";
              st = "status";
              p = "push";
            };
            userEmail = "winstonwalter07@gmail.com";
            userName = "blank2121";
          };
          programs.gh.enable = config.clis.configurable.git.enable;
          programs.lazygit.enable = config.clis.configurable.git.enable;

          # gpg
          services.gpg-agent = {
            enable = config.clis.configurable.gpg.enable;
            pinentryPackage = pkgs.pinentry-curses;
            enableExtraSocket = true;
            enableSshSupport = true;
          };

          programs.gpg = {
            enable = config.clis.configurable.gpg.enable;
            publicKeys = [
              {
                source = "/home/${username}/nixcfg/gpg-key/subkey.pub";
                trust = 5;
              }
            ];
          };

          # pass-store
          home.packages = [ pkgs.pass ];
          programs.password-store.enable = config.clis.configurable.pass.enable; 

          # zellij
          programs.zellij = {
            enable = config.clis.configurable.zellij.enable;
            enableZshIntegration = true;
          };
          home.file = lib.mkIf config.clis.configurable.zellij.enable {
            ".config/zellij/" = {
                recursive = true;
                source = "/home/${username}/nixcfg/dotfiles/zellij";
            };
          };

          # other general clis
          programs = {
            eza = {
              enable = true;
              icons = "auto";
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
        };
    };
}

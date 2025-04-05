{ 
    inputs,
    lib,
    pkgs,
    username ? "default",
    config,
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
        clis.editors.enable = boolOption "all nixvim, helix, and yazi";
        clis.editors.nixvim.enable = boolOption "nixvim"; 
        clis.editors.helix.enable = boolOption "helix"; 
        clis.editors.yazi.enable = boolOption "yazi"; 
    };

    config = lib.mkIf config.clis.editors.enable {

        home-manager.users.${username} = {
          # helix config
          programs.helix = {
              enable = config.clis.editors.helix.enable;
              settings = {
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

          # yazi config      
          programs.yazi = {
            enable = config.clis.editors.yazi.enable;
            enableZshIntegration = true;
            keymap = {
              manager = {
                prepend_keymap = [
                  {
                     desc = "Set hovered file as wallpaper";
                     on = [ "b" "g" ];
                     run = "shell --confirm \"swww img --transition-type=any $0\"";
                  }
                ];
              };
            };
          };
        }; 

        # nixvim config
        environment.systemPackages = [
            inputs.nixvim.packages.${pkgs.system}.code
            inputs.nixvim.packages.${pkgs.system}.writer
        ];
    };
}

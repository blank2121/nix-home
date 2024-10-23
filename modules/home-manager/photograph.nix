{ config, lib, pkgs, ... }:
let
    photoapps = with pkgs; [
        halftone
        gthumb
        gimp
    ];
in {
    options = {
        photography.enable = lib.mkOption {
            default = true;
            description = ''
                whether or not to add apps for photography
            '';
        };
    };

    config = {
        home.packages = (if config.photography.enable then photoapps else []);
    };
}

{ pkgs, ... }:

{
    home.packages = [
        # pkgs.rofi-pass-wayland
        pkgs.pass
    ];

    programs.password-store.enable = true; 
}

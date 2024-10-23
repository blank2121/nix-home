{ config, pkgs, lib, ... }:
with lib.mkOption;
let
  waybarPath = "/home/winston/myHome/dotfiles/.config/waybar";

  waybar = pkgs.pkgs.writeShellScriptBin "waybar" ''
    exec ${pkgs.waybar}/bin/waybar --config ${waybarPath}/config.jsonc --style ${waybarPath}/style.css &
  '';

  wallpaper = pkgs.pkgs.writeShellScriptBin "wallpaper" ''
    ${pkgs.swww}/bin/swww init
  '';

  volumeUp = pkgs.pkgs.writeShellScriptBin "up" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%+
  '';

  volumeDown = pkgs.pkgs.writeShellScriptBin "down" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%-
  '';

  screenshot = pkgs.pkgs.writeShellScriptBin "screenshot" ''
    save_dir="$HOME/Pictures/Screenshots"

    # Create the directory if it doesn't exist
    mkdir -p "$save_dir"

    # Get the geometry from slurp (user selection)
    geometry=$(${pkgs.slurp}/bin/slurp)

    # Check if geometry is empty (escape was pressed or selection is invalid)
    if [ -z "$geometry" ]; then
        echo "No selection made, exiting without saving screenshot."
        exit 0
    fi

    # Set the base filename with the current date
    base_filename="screenshot-$(date -I)"
    extension=".png"
    filename="$save_dir/$base_filename$extension"

    # Check if a file with the same name already exists
    n=1
    while [ -e "$filename" ]; do
        filename="$save_dir/$base_filename($n)$extension"
        ((n++))
    done

    # Capture screenshot with grim, process it with convert, and save to the determined filename
    ${pkgs.grim}/bin/grim -g "$geometry" - | ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- > "$filename"
  '';
in {
    options = {
        niri.enable = lib.mkOption {
            default = false;
        };
    };

    config = {
        environment.systemPackages = with pkgs; [
            cage
            wayland-utils
            xwayland-satellite-unstable
            gamescope
        ];
    
        # niri config 
        systemd.user.services.niri-flake-polkit.enable = false;
        programs.niri.enable = config.niri.enable;
        home-manager.users.winston.programs.niri = {
            package = pkgs.niri-stable;
            settings = {
                outputs."eDP-1".scale = 1.5;
                spawn-at-startup = [
                    { command = ["${waybar}/bin/waybar"];}
                    { command = ["${wallpaper}/bin/wallpaper"]; }
                ];
                input = {
                    keyboard.xkb = {
                        layout = "us,es";
                        options = "grp:win_space_toggle";
                    };
                    touchpad = {
                        # accel-profile = "adaptive";
                        # accel-speed = 0;
                        click-method = "clickfinger";
                        natural-scroll = true;
                        scroll-method = "two-finger";
                        tap = true;
                    };
                };
                layout = {
                    gaps = 16;
                    center-focused-column = "never";
                    preset-column-widths = [
                        { proportion = 1.0 / 3.0; }
                        { proportion = 1.0 / 2.0; }
                        { proportion = 2.0 / 3.0; }
                    ];
                    default-column-width = { proportion = 1.0; };
                    focus-ring = {
                        width = 4;
                    };
                    struts = {
                        left = 48;
                        right = 48;
                        bottom = 32;
                        top = 32;
                    };
                };
                binds = with config.home-manager.users.winston.lib.niri.actions; let
                    mod = "Alt";
                in {
                    "XF86AudioRaiseVolume".action = spawn "${volumeUp}/bin/up";
                    "XF86AudioLowerVolume".action = spawn "${volumeDown}/bin/down";

                    "${mod}+F".action = fullscreen-window;
                    "${mod}+M".action = spawn "swaync-client" "-t";
                    "${mod}+Return".action = spawn "kitty";
                    "${mod}+Shift+E".action = spawn "${pkgs.wlogout}/bin/wlogout";
                    "${mod}+Shift+Q".action = close-window;
                    "${mod}+Space".action = spawn "${pkgs.fuzzel}/bin/fuzzel";
                    "Ctrl+Shift+P".action = spawn "${pkgs.wofi-pass}/bin/wofi-pass";
                    "Ctrl+Shift+S".action = spawn "${screenshot}/bin/screenshot";

                    # movement
                    "${mod}+H".action = focus-column-left;
                    "${mod}+L".action = focus-column-right;
                    "${mod}+K".action = focus-window-or-workspace-up;
                    "${mod}+J".action = focus-window-or-workspace-down;


                    # window manipulation
                    "${mod}+Shift+H".action = move-column-left;
                    "${mod}+Shift+L".action = move-column-right;
                    "${mod}+Shift+K".action = move-window-up-or-to-workspace-up;
                    "${mod}+Shift+J".action = move-window-down-or-to-workspace-down;

                    "${mod}+Minus".action = set-column-width "-10%";
                    "${mod}+Equal".action = set-column-width "+10%";

                    "${mod}+Shift+Minus".action = set-window-height "-10%";
                    "${mod}+Shift+Equal".action = set-window-height "+10%";

                    "${mod}+A".action = consume-window-into-column;
                    "${mod}+R".action = expel-window-from-column;
                    "${mod}+S".action = switch-preset-column-width;

                    # workspaces
                    "${mod}+1".action = focus-workspace 1;
                    "${mod}+2".action = focus-workspace 2;
                    "${mod}+3".action = focus-workspace 3;
                    "${mod}+4".action = focus-workspace 4;
                    "${mod}+5".action = focus-workspace 5;
                    "${mod}+6".action = focus-workspace 6;
                    "${mod}+7".action = focus-workspace 7;
                    "${mod}+8".action = focus-workspace 8;
                    "${mod}+9".action = focus-workspace 9;

                    "${mod}+Shift+1".action = move-column-to-workspace 1;
                    "${mod}+Shift+2".action = move-column-to-workspace 2;
                    "${mod}+Shift+3".action = move-column-to-workspace 3;
                    "${mod}+Shift+4".action = move-column-to-workspace 4;
                    "${mod}+Shift+5".action = move-column-to-workspace 5;
                    "${mod}+Shift+6".action = move-column-to-workspace 6;
                    "${mod}+Shift+7".action = move-column-to-workspace 7;
                    "${mod}+Shift+8".action = move-column-to-workspace 8;
                    "${mod}+Shift+9".action = move-column-to-workspace 9;
                };
            };
        };
    };
}

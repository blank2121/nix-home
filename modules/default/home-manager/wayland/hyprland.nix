{ config, pkgs, lib, ... }:
let
  startup = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 0.1

    ${pkgs.swww}/bin/swww init &
    exec ${pkgs.waybar}/bin/waybar &
  '';

  volumeUp = pkgs.pkgs.writeShellScriptBin "up" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%+
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

  volumeDown = pkgs.pkgs.writeShellScriptBin "down" ''
    ${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%-
  '';
in {
  imports = [
    ./apps/waybar.nix
  ];

  home.packages = with pkgs; [
    swww
    waybar
    wineWowPackages.waylandFull
    wl-clipboard
    wlogout
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = pkgs.hyprland.override {
        debug = true;
    };

    settings = {
      monitor = [
        ",highres,0x0,auto"
        "HDMI-A-1,prefered,auto,1,mirror,eDP-2"
      ];
      exec-once = ''${startup}/bin/start'';
      env = [
        "XCURSOR_SIZE,24"
        "GDK_SCALE,auto"
      ];
      xwayland = {
        force_zero_scaling = "true";
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = "1";
        
        touchpad = {
          natural_scroll = "yes";
          scroll_factor = "0.25";
          disable_while_typing = "false";
        };

        sensitivity = "0";
      };
      general = {
        gaps_in = "5";
        gaps_out = "50";
        border_size = "2";

        layout = "dwindle";

        allow_tearing = "false";
      };

      decoration = {
        rounding = "10";
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };
        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = "on";
      };

      misc = {
        force_default_wallpaper = "0";
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.7";
      };

      "$mainMod" = "ALT";

      binde = [
        ",xf86audioraisevolume, exec, ${volumeUp}/bin/up" 
        ",xf86audiolowervolume, exec, ${volumeDown}/bin/down"
      ];

      bind = [
        "CTRL SHIFT, S, exec, ${screenshot}/bin/screenshot"
        "$mainMod, RETURN, exec, foot"
        "$mainMod SHIFT, Q, killactive, "
        "$mainMod, E, exec, wlogout"
        "$mainMod SHIFT, Space, togglefloating, "
        "$mainMod, SPACE, exec, rofi -show drun"

        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, D, togglesplit, # dwindle"
        "$mainMod, F, fullscreen"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];
    };
  };

  # home.file.".config/hypr/hyprland.conf".source = ../../../../dotfiles/.config/hypr/hyprland.conf;
}

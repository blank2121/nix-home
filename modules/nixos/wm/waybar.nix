{ pkgs, config, ... }:
{
  home-manager.users.winston.programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 31;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;

        modules-left = [
          "custom/padd"
          "custom/l_end"
          "custom/power"
          "custom/padd"
          "custom/wallchange"
          "custom/r_end"
          "custom/l_end"
          "wlr/taskbar"
          "custom/r_end"
          ""
          "custom/padd"
        ];
        modules-center = [
          "custom/padd"
          "custom/l_end"
          "idle_inhibitor"
          "clock"
          "custom/r_end"
          "custom/padd"
        ];
        modules-right = [
          "custom/padd"
          "custom/l_end"
          "tray"
          "battery"
          "custom/r_end"
          "custom/spotify"
          "custom/l_end"
          "backlight"
          "network"
          "bluetooth"
          "pulseaudio"
          "pulseaudio#microphone"
          "custom/r_end"
          "custom/padd"
        ];

        "custom/power" = {
          format = " {}";
          exec = "echo ; echo  logout";
          on-click = "wlogout";
          interval = 86400;
          tooltip = true;
        };

        "custom/wallchange" = {
          format = "󰋰 {}";
          exec = "echo ; echo 󰋰 random wallpaper";
          on-click = "nix run ~/shells/#random-wallpaper ~/Pictures/wallpaper/";
          interval = 86400;
          tooltip = true;
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          icon-theme = "Tela-circle-dracula";
          spacing = 0;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [
            "Alacritty"
          ];
          app_ids-mapping = {
            firefoxdeveloperedition = "firefox-developer-edition";
          };
        };

        "custom/spotify" = {
          exec = "echo ; echo \"Playing $(${pkgs.playerctl}/bin/playerctl metadata title --player=spotify) by $(${pkgs.playerctl}/bin/playerctl metadata artist --player=spotify)\"";
          format = " {}";
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause --player=spotify";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next --player spotify";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl previous --player spotify";
          interval = 20;
          max-length = 25;
          escape = true;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰥔 ";
            deactivated = " ";
          };
        };

        "clock" = {
          format = "{:%I:%M %p}";
          format-alt = "{:%R 󰃭 %d·%m·%y}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "tray" = {
          icon-size = 18;
          spacing = 5;
        };

        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 2;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          min-length = 6;
        };

        "network" = {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󱘖 Wired";
          tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = " Disconnected";
          format-alt = "󰤨 {signalStrength}%";
          interval = 5;
        };

        "bluetooth" = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
        };

        "pulseaudio" = {
          format = "{icon}";
          format-muted = "停";
          on-click = "${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master toggle";
          on-click-middle = "${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master toggle";
          on-scroll-up = "${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%+";
          on-scroll-down = "${pkgs.alsa-utils}/bin/amixer -D pipewire sset Master 5%-";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 5;
          "format-icons" = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              " "
              " "
            ];
          };
        };

        "custom/l_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/r_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/sl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/sr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/rl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/rr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/padd" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };
      };
    };
  };
}

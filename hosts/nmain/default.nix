{
  config,
  pkgs,
  ...
}:
{
    imports = [
        ./configuration.nix
        ./hardware-configuration.nix
        ../../modules/default.nix
    ];

    clis = {
        unconfigured.enable = true;
        configurable = {
            enable = true;
            git.enable = true;
            gpg.enable = true;
            pass.enable = true;
            zellij.enable = true;
        };
        editors = {
            enable = true;
            nixvim.enable = true;
            helix.enable = true;
            yazi.enable = true;
        };
        shell.enable = true;
    };

    guis = {
        enable = true;
        games.enable = false;
        # TODO: unhashtag HSR from games. was editing without wifi and fetch caused errors.
    };

    sys = {
        extraHosts = ''
            0.0.0.0 log-upload-os.hoyoverse.com
            0.0.0.0 sg-public-data-api.hoyoverse.com
        '';
        timeZone = "America/New_York";

        battery = {
            enable = true;
            chargeMin = 40;
            chargeMax = 85;
        };
        gpu.amd.enable = true;
        audio.enable = true;
        stylix.enable = true;
        desktopEnvironment = {
            niri.enable = true;

            screenSize = { x = 2560; y = 1600; };

            modules = {
                swaylock.enable = true;
                swaync.enable = true;
                waybar.enable = true;
                wlogout.enable = true;
            };
        };
        login.ly.enable = true;
    };
}

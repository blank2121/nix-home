{ config, pkgs, ... }:

let
  alias = {
    bt = "bluetoothctl";
    mpv = "flatpak run io.mpv.Mpv";
    notify-send = "dunstify";
    nv = "nvim";
    rm = "trash-put";
    cd = "z";
    times = "sudo -E timeshift-gtk";
    wallpaper = "nix run ~/shells/#random-wallpaper ~/Pictures/wallpaper/";
    zj = "zellij";
  };
  extra = ''
    $env.PATH = ($env.PATH | split row (char esep) | append "$env.HOME/.cargo/bin")
    $env.PATH = ($env.PATH | split row (char esep) | append "$env.HOME/.julia/packages/LanguageServer/Fwm1f/src/LanguageServer.jl")
    
    # starship setup
    mkdir ~/.cache/starship
    starship init nu | save -f ~/.cache/starship/init.nu
    use ~/.cache/starship/init.nu

    # zoxide setup
    zoxide init nushell | save -f ~/.zoxide.nu
    source ~/.zoxide.nu
  '';
    # previously in extra
    # eval "$(starship init zsh)"
    # eval "$(zoxide init zsh)"
  envs = {
    EDITOR = "^nvim";
    NIXPKGS_ALLOW_BROKEN = "1";
    NIXPKGS_ALLOW_INSECURE = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    STARSHIP_CONFIG="($env.HOME/myHome/dotfiles/.config/starship.toml)";
  };
in {
  programs.nushell = {
    enable = true;
    shellAliases = alias;
    extraEnv = extra;
    #environmentVariables = envs;
  };
}

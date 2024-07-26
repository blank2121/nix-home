{ config, pkgs, ... }:

let
  alias = {
    bt = "bluetoothctl";
    lf = "~/myHome/dotfiles/.config/lf/lfub";
    mpv = "flatpak run io.mpv.Mpv";
    notify-send = "dunstify";
    nv = "nvim";
    rm = "trash-put";
    times = "sudo -E timeshift-gtk";
    wallpaper = "swww img --transition-type=any";
    zj = "zellij";
  };
  extra = ''
    export EDITOR="nvim"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.julia/packages/LanguageServer/Fwm1f/src/LanguageServer.jl:$PATH"
    export NIXPKGS_ALLOW_INSECURE=1
    export NIXPKGS_ALLOW_BROKEN=1
    export NIXPKGS_ALLOW_UNFREE=1
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
  '';
in
{
  programs.zsh = {
    autocd = true;
    enable = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = alias;
    syntaxHighlighting.enable = true;
    envExtra = extra;
  };
}

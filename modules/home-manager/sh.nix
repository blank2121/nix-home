{
  config,
  pkgs,
  inputs,
  ...
}:
let
  alias = {
    bt = "bluetoothctl";
    mpv = "flatpak run io.mpv.Mpv";
    nv = "${inputs.nixvim.packages.${pkgs.system}.code}/bin/nvim";
    wr = "${inputs.nixvim.packages.${pkgs.system}.writer}/bin/nvim";
    rm = "trash-put";
    cd = "z";
    times = "sudo -E timeshift-gtk";
    wallpaper = "nix run ~/shells/#random-wallpaper ~/Pictures/wallpaper/";
    zj = "zellij";
    ls = "eza --icons=always";
  };
  extra = ''
    export EDITOR="nvim"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.julia/packages/LanguageServer/Fwm1f/src/LanguageServer.jl:$PATH"
    export NIXPKGS_ALLOW_INSECURE=1
    export NIXPKGS_ALLOW_BROKEN=1
    export NIXPKGS_ALLOW_UNFREE=1
    export STARSHIP_CONFIG=/home/winston/nixcfg/dotfiles/starship.toml
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    eval $(thefuck --alias)
    ${pkgs.nitch}/bin/nitch 
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

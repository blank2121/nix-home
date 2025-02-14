{ config, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = config.home.homeDirectory + "/nixcfg/dotfiles/zellij";
    };
  };
}

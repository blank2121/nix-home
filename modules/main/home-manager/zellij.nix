{ config, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = config.home.homeDirectory + "/myHome/dotfiles/.config/zellij"; 
    };
  };
}

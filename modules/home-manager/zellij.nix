{ config, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = config.home.homeDirectory + "/myHome/dotfiles/.config/zellij"; 
    };
  };
}

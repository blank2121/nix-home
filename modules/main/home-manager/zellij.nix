{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = ../../../dotfiles/.config/zellij;
    };
  };
}

{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = ../../../dotfiles/.config/zellij;
    };
  };
}

{ username ? "winston", ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/zellij/" = {
      recursive = true;
      source = "/home/${username}/nixcfg/dotfiles/zellij";
    };
  };
}

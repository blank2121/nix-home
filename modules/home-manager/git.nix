{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      a = "add";
      cm = "commit";
      co = "checkout";
      st = "status";
      p = "push";
    };
    userEmail = "winstonwalter07@gmail.com";
    userName = "blank2121";
  };
  programs.gh.enable = true;
  programs.lazygit.enable = true;
}

{pkgs, ...}:

{
  programs.git = {
    enable = true;
    aliases = {
      a = "add";
      cm = "commit";
      co = "checkout";
      st = "status";
    };
    userEmail = "winstonwalter07@gmail.com";
    userName = "blank2121";
  };
  programs.gh.enable = true;
  programs.gitui.enable = true;
}

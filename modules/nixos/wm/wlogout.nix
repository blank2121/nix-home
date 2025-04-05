{
  username ? "winston",
  ...
}:
{
  home-manager.users.${username}.programs.wlogout = {
    enable = true;
    style = ''
      window {
          background-color: rgba(129, 51, 184, 0.1);
      }
    '';
  };
}

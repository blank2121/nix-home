{
  username ? "winston",
  ...
}:
{
  home-manager.users.${username}.programs.swaylock = {
    enable = true;
    settings = {
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };
}

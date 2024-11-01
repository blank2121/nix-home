{ ... }:
{
  home-manager.users.winston.programs.swaylock = {
    enable = true;
    settings = {
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };
}

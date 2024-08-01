{ ... }:

{
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
  services.flatpak.packages = [
    "net.labymod.LabyMod"
  ];
}

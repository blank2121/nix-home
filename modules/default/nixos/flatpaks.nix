{ ... }:

{
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
  services.flatpak.packages = [
    "dev.vencord.Vesktop"
    "md.obsidian.Obsidian"
    "net.kuribo64.melonDS"
    "info.febvre.Komikku"
    "com.github.tchx84.Flatseal"
    "org.libreoffice.LibreOffice"
  ];
}

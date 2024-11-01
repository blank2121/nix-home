{ pkgs, ... }:
{
  home.packages = [
    pkgs.pass
  ];

  programs.password-store.enable = true;
}

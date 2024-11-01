{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nixvim.packages.${pkgs.system}.default
    inputs.writer.packages.${pkgs.system}.default
  ];
}

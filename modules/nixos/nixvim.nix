{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nixvim.packages.${pkgs.system}.code
    inputs.nixvim.packages.${pkgs.system}.writer
  ];
}

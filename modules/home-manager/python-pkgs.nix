{ config, pkgs, ... }:
{
  home.packages = with pkgs.python312Packages; [
    # dataset
    matplotlib
    numpy
    pandas
    scikit-learn
    seaborn
    chromadb
  ];
}

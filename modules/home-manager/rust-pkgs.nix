{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    clippy
    rustfmt
    rust-analyzer
    rustc
    # rustup
  ];
}

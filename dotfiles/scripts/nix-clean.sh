#!/bin/sh

echo "routine nix cleaning in progress..."

nix-collect-garbage
nix-store --gc

clear

echo "NixPKGs cleaned!"

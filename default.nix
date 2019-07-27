{ pkgs ? import <nixpkgs> { } }:

with pkgs;

{
  use-db = callPackage ./use-db { };
  use-queue = callPackage ./use-queue { };
}

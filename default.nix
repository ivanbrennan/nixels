{ pkgs ? import <nixpkgs> { } }:

{
  use-db = pkgs.callPackage ./use-db { };
}

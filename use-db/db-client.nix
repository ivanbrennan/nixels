{ bash
, findutils
, lib
, makeWrapper
, postgresql
, runCommand
, stdenv
}:

let
  propagatedBuildInputs = [
    bash
    findutils
    postgresql
  ];

in runCommand "db-client" {
  inherit propagatedBuildInputs;
  nativeBuildInputs = [ makeWrapper ];
} ''
  install -D -m755 ${./db-client} $out/bin/$name
  patchShebangs --host $out/bin

  ${stdenv.shell} -n $out/bin/$name

  wrapProgram $out/bin/$name \
      --prefix PATH : "${lib.makeBinPath propagatedBuildInputs}"

  mkdir -p $out/nix-support
  printWords ${toString propagatedBuildInputs} \
      > $out/nix-support/propagated-build-inputs
''

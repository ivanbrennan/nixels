{ bash
, findutils
, lib
, makeWrapper
, redis
, runCommand
, stdenv
}:

let
  propagatedBuildInputs = [
    bash
    findutils
    redis
  ];

in runCommand "queue-client" {
  inherit propagatedBuildInputs;
  nativeBuildInputs = [ makeWrapper ];
} ''
  install -D -m755 ${./queue-client} $out/bin/$name
  patchShebangs --host $out/bin

  ${stdenv.shell} -n $out/bin/$name

  wrapProgram $out/bin/$name \
      --prefix PATH : "${lib.makeBinPath propagatedBuildInputs}"

  mkdir -p $out/nix-support
  printWords ${toString propagatedBuildInputs} \
      > $out/nix-support/propagated-build-inputs
''

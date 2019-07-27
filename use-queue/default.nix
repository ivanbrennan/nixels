{ pkgs }:

with pkgs;

let
  aliases = copyPathToStore ./aliases;
  queue-env = copyPathToStore ./queue.env;
  queue-client = callPackage ./queue-client.nix { };

in mkShell {
  pname = "use-queue";
  version = "0.1.0";

  buildInputs = [
    redis
  ];

  shellHook = ''
    set -e

    . ${aliases}
    . ${queue-env}
    trap "'${queue-client}/bin/queue-client' remove" EXIT
    '${queue-client}/bin/queue-client' add

    set +e
  '';
}

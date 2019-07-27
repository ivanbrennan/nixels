{ pkgs }:

with pkgs;

let
  db-env = copyPathToStore ./db.env;
  db-client = callPackage ./db-client.nix { };

in mkShell {
  pname = "use-db";
  version = "0.1.0";

  buildInputs = [
    glibcLocales
    postgresql
  ];

  shellHook = ''
    set -e

    export LANG=en_US.UTF-8
    . ${db-env}
    trap "'${db-client}/bin/db-client' remove" EXIT
    '${db-client}/bin/db-client' add

    set +e
  '';
}

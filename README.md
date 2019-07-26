## nixels

This is a collection of nix-shell recipes organized under a top-level
[default.nix](default.nix) expression. It's structured so recipes can be
referenced by attribute name:
```sh
nix-shell --attr use-db \
    https://github.com/ivanbrennan/nixels/archive/master.tar.gz
```

Recipes are versioned and git tags of the form `<recipe>-<version>` are
provided, allowing you to reference a particular version:
```sh
nix-shell --attr use-db \
    https://github.com/ivanbrennan/nixels/archive/use-db-0.1.0.tar.gz
```

I've also written a CLI,
[shellbit](https://github.com/ivanbrennan/shellbit#shellbit), to make
referencing recipe collections like this one less cumbersome:
```sh
$ cd /path/to/projects/use-db
$ shellbit
[nix-shell:~/Development/use-db]$
```

#with (import <nixpkgs> {});
#derivation {
#  name = "hello";
#  builder = "${bash}/bin/bash";
#  args = [ ./hello_builder.sh ];
#  inherit gnutar gzip gnumake gcc coreutils gawk gnused gnugrep;
#  binutils = binutils-unwrapped;
#  src = ./hello-2.10.tar.gz;
#  system = builtins.currentSystem;
#}
#with (import <nixpkgs> {});
#derivation {
#  name = "hello";
#  builder = "${bash}/bin/bash";
#  args = [ ./builder.sh ];
#  buildInputs = [ gnutar gzip gnumake gcc binutils-unwrapped coreutils gawk gnused gnugrep ];
#  src = ./hello-2.10.tar.gz;
#  system = builtins.currentSystem;
#}

let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in mkDerivation {
  name = "hello";
  src = ./hello-2.10.tar.gz;
}

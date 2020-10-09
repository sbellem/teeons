# code for section 12.7 (The inputs pattern)
{ mkDerivation, fetchurl }:

mkDerivation {
  name = "hello";
  version = "2.10";
  #src = builtins.fetchurl {
  src = fetchurl {
    #url = "mirror://gnu/hello/${name}-${version}.tar.gz";
    url = "mirror://gnu/hello/hello-2.10.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };
}

# code for section < 12.7
#let
#  pkgs = import <nixpkgs> {};
#  mkDerivation = import ./autotools.nix pkgs;
#in mkDerivation {
#  name = "hello";
#  version = "2.10";
#  src = builtins.fetchurl {
#    #url = "mirror://gnu/hello/${name}-${version}.tar.gz";
#    url = "mirror://gnu/hello/hello-2.10.tar.gz";
#    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
#  };
#}

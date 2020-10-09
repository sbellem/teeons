with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "hello";
  #src = ./hello-2.10.tar.gz;
  #src = builtins.fetchurl {
  src = builtins.fetchurl {
    #url = "mirror://gnu/hello/${name}-${version}.tar.gz";
    url = "mirror://gnu/hello/hello-2.10.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };
}

let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
  inherit (pkgs) fetchurl;
in mkDerivation {
  name = "hello";
  version = "2.10";
  src = fetchurl {
    #url = "mirror://gnu/hello/${name}-${version}.tar.gz";
    url = "mirror://gnu/hello/hello-2.10.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };
}

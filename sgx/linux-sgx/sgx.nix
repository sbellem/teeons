with import <nixpkgs> {};

let
  binutils = import ./binutils.nix {
    inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  };
in

stdenv.mkDerivation {
  name = "sgx";
  src = fetchFromGitHub {
    owner = "intel";
    repo = "linux-sgx";
    rev = "33f4499173497bdfdf72c5f61374c0fadc5c5365";
    # Command to get the sha256 hash (note the --fetch-submodules arg):
    # nix run -f '<nixpkgs>' nix-prefetch-github -c nix-prefetch-github \
    #   --fetch-submodules \
    #   --rev 33f4499173497bdfdf72c5f61374c0fadc5c5365 intel linux-sgx
    sha256 = "009hlkgnn3wvbsnawpfcwdxyncax9mb260vmh9anb91lmqbj74rp";
    fetchSubmodules = true;
  };
  #buildInputs = [(import ./binutils.nix {
  #  inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  #}) cmake];
  inherit binutils;
  buildInputs = [binutils cmake];
  builder = ./builder.sh;
}

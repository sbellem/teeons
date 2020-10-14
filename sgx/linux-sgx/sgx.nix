with import <nixpkgs> {};

let
  #name = "sgx-ipp_crypto";
  ipp_crypto = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/optimized_libs_2.11.tar.gz";
    sha256 = "43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162";
  };
  
  #name = "asldobjdump";
  #asldobjdump = fetchurl {
  #  url = "https://download.01.org/intel-sgx/sgx-linux/2.11/as.ld.objdump.gold.r2.tar.gz";
  #  sha256 = "97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0";
  #};

  xbinutils = import ./binutils.nix {
    inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  };
in

stdenvNoCC.mkDerivation {
  inherit ipp_crypto xbinutils;
  name = "sgx";
  src = fetchFromGitHub {
    #owner = "intel";
    owner = "sbellem";
    repo = "linux-sgx";
    #rev = "33f4499173497bdfdf72c5f61374c0fadc5c5365";
    # rev = "blue";
    rev = "ccce642ba2afa5408561497da68f83f348ce3b5f";
    # Command to get the sha256 hash (note the --fetch-submodules arg):
    # nix run -f '<nixpkgs>' nix-prefetch-github -c nix-prefetch-github \
    #   --fetch-submodules \
    #   --rev ccce642ba2afa5408561497da68f83f348ce3b5f sbellem linux-sgx
    #sha256 = "009hlkgnn3wvbsnawpfcwdxyncax9mb260vmh9anb91lmqbj74rp";
    sha256 = "0k93p5drzv9fs02wgsf6i6wv9z3d5yr5j41xlnhp473356ap9130";
    fetchSubmodules = true;
  };
  #tar -C $sourceRoot -xvf $asldobjdump;
  postUnpack = ''
    tar -C $sourceRoot -xvf $ipp_crypto;
    '';
  #postUnpack = ''
  #  cd $sourceRoot/external/openmp/openmp_code && git apply --verbose ../0001-Enable-OpenMP-in-SGX.patch >/dev/null 2>&1 ||  git apply --verbose ../0001-Enable-OpenMP-in-SGX.patch --check -R
  #'';
  #prePatch = ''
  #  cd $sourceRoot/external/openmp/openmp_code
  #'';
  #patches = ["../0001-Enable-OpenMP-in-SGX.patch"];
  #buildInputs = [(import ./binutils.nix {
  #  inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  #}) cmake];
  #inherit xbinutils;
  buildInputs = [
    xbinutils
    autoconf
    automake
    binutils
    libtool
    ocaml
    ocamlPackages.ocamlbuild
    file
    cmake
    gnum4
    openssl
    #linux-headers
    linuxHeaders
    glibc
    #gcc-wrapper
    gcc8
    texinfo
    bison
    flex
    zlib
];
  builder = ./builder.sh;
  dontConfigure = true;
  buildPhase = ''
    export BINUTILS_DIR=${xbinutils}/bin
    '';
  buildFlags = ["sdk"];
  dontInstall = true;
  dontFixup = true;
}

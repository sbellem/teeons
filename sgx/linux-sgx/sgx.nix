with import <nixpkgs> {};
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/10e61bf5be57736035ec7a804cb0bf3d083bf2cf.tar.gz") {} }:
#{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-20.03.tar.gz") {} }:
with pkgs;

let
  #name = "sgx-ipp_crypto";
  ipp_crypto = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/optimized_libs_2.11.tar.gz";
    sha256 = "43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162";
    #sha256 = "43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162";
  };
  
  #name = "asldobjdump";
  asldobjdump = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/as.ld.objdump.gold.r2.tar.gz";
    sha256 = "97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0";
  };

  #xbinutils = import ./binutils.nix {
  #  inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  #};
in

#stdenvNoCC.mkDerivation {
stdenvNoCC.mkDerivation {
  #inherit ipp_crypto xbinutils;
  inherit ipp_crypto asldobjdump;
  name = "sgx";
  src = fetchFromGitHub {
    owner = "intel";
    repo = "linux-sgx";
    rev = "33f4499173497bdfdf72c5f61374c0fadc5c5365";
    # Command to get the sha256 hash (note the --fetch-submodules arg):
    # nix run -f '<nixpkgs>' nix-prefetch-github -c nix-prefetch-github --fetch-submodules --rev 33f4499173497bdfdf72c5f61374c0fadc5c5365 intel linux-sgx
    sha256 = "009hlkgnn3wvbsnawpfcwdxyncax9mb260vmh9anb91lmqbj74rp";
    fetchSubmodules = true;
  };
  #tar -C $sourceRoot -xvf $asldobjdump;
  postUnpack = ''
    tar -C $sourceRoot -xvf $ipp_crypto
    tar -C $sourceRoot -xvf $asldobjdump
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
    #xbinutils
    autoconf
    automake
    #binutils-unwrapped
    libtool
    ocaml
    ocamlPackages.ocamlbuild
    file
    cmake
    gnum4
    openssl
    gnumake
    #linuxHeaders
    #glibc
    #gcc8
    #/nix/store/yg76yir7rkxkfz6p77w4vjasi3cgc0q6-gnumake-4.2.1
    #/nix/store/5lyvydxv0w4f2s1ba84pjlbpvqkgn1ni-linux-headers-4.19.16
    /nix/store/681354n3k44r8z90m35hm8945vsp95h1-glibc-2.27
    /nix/store/1kl6ms8x56iyhylb2r83lq7j3jbnix7w-binutils-2.31.1
    /nix/store/lvwq3g3093injr86lm0kp0f61k5cbpay-gcc-wrapper-8.3.0
    texinfo
    bison
    flex
];
  dontConfigure = true;
  #buildPhase = ''
  #  export BINUTILS_DIR=${xbinutils}/bin
  #  echo $BINUTILS_DIR
  #  '';
  buildFlags = ["sdk"];
  dontInstall = true;
  dontFixup = true;
}

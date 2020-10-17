{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/10e61bf5be57736035ec7a804cb0bf3d083bf2cf.tar.gz") {} }:
#{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-19.09.tar.gz") {} }:
with pkgs;

let
  ipp_crypto = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/optimized_libs_2.11.tar.gz";
    sha256 = "43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162";
  };
  
  asldobjdump = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/as.ld.objdump.gold.r2.tar.gz";
    sha256 = "97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0";
  };
  #asldobjdump = import ./asldobjdump.nix {
  #  inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  #};

in
stdenvNoCC.mkDerivation {
  inherit ipp_crypto asldobjdump;
  name = "sgx";
  src = fetchFromGitHub {
    owner = "sbellem";
    repo = "linux-sgx";
    rev = "4f3ec1dd89e06efbc6ebd2a8ef85eb1a7ded3130";
    # Command to get the sha256 hash (note the --fetch-submodules arg):
    # nix run -f '<nixpkgs>' nix-prefetch-github -c nix-prefetch-github --fetch-submodules --rev 4f3ec1dd89e06efbc6ebd2a8ef85eb1a7ded3130 sbellem linux-sgx
    sha256 = "08f3divshmc644xdbzlm2v4wvmkj6sik07pi60d1cr1zga888khf";
    # patched openmp - for-nix branch
    #rev = "91e4ad5ae0b8e8de605b5275563b98bca53ee565";
    #sha256 = "1s058acjkgakfp9av5xa5nr3lxdlxb3qq1050wzb7s1kacrcl04d";
    fetchSubmodules = true;
  };
  #tar -C $sourceRoot -xvf $asldobjdump
  #export BINUTILS_DIR=$PWD/$sourceRoot/external/toolset/nix
  postUnpack = ''
    tar -C $sourceRoot -xvf $ipp_crypto
    tar -C $sourceRoot -xvf $asldobjdump
    export BINUTILS_DIR=$PWD/$sourceRoot/external/toolset/nix
    '';
  dontConfigure = true;
  #export BINUTILS_DIR=$asldobjdump/bin
  #preBuild = ''
  #  export BINUTILS_DIR=$PWD/$sourceRoot/external/toolset/nix
  #'';
  buildInputs = [
    #asldobjdump
    autoconf
    automake
    libtool
    ocaml
    ocamlPackages.ocamlbuild
    file
    cmake
    gnum4
    openssl
    gnumake
    #glibc
    /nix/store/681354n3k44r8z90m35hm8945vsp95h1-glibc-2.27
    gcc8
    texinfo
    bison
    flex
    perl
    python3
    which
    git
  ];
  propagatedBuildInputs = [ gcc8 ];
  #buildPhase = ''
  #  export BINUTILS_DIR=$sourceRoot/external/toolset/nix
  #  echo $BINUTILS_DIR
  #  '';
  buildFlags = ["sdk_install_pkg"];
  dontInstall = true;
  postBuild = ''
    echo -e 'no\n'$out | ./linux/installer/bin/sgx_linux_x64_sdk_2.11.100.2.bin
    '';

  dontFixup = true;
  shellHook = ''
  echo "SGX build enviroment"
  '';
}

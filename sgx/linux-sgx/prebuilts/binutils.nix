with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "asldobjdump";
  src = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/as.ld.objdump.gold.r2.tar.gz";
    sha256 = "97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0";
  };
  #builder = ./builder.sh;
}

with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "prebuilt_ae";
  src = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/prebuilt_ae_2.11.tar.gz";
    sha256 = "820c713f6b4531b7ba475fdb288d616647277d5ab1601998c6dc50d761b8869e";
  };
  #builder = ./builder.sh;
}

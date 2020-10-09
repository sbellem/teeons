with import <nixpkgs> {};

# 43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162  optimized_libs_2.11.tar.gz
# 97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0  as.ld.objdump.gold.r2.tar.gz

stdenv.mkDerivation {
  name = "optimized_libs";
  src = fetchurl {
    url = "https://download.01.org/intel-sgx/sgx-linux/2.11/optimized_libs_2.11.tar.gz";
    sha256 = "43ad0859114c1e78a4381a9bd6a03929499c0e1b268cc7f719e9b65e53127162";
  };
  #builder = ./builder.sh;
}

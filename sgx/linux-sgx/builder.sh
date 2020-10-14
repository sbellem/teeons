source $stdenv/setup

echo ${xbinutils}.outPath
export BINUTILS_DIR=${xbinutils}/bin
cd $src
make sdk

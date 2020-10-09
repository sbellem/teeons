source $stdenv/setup

cd binutils-2.35
make clean
#./configure --prefix=/usr/local --enable-gold --enable-ld=default --enable-plugins --enable-shared --disable-werror --enable-64-bit-bfd --with-system-zlib
./configure --enable-gold
make
#make install

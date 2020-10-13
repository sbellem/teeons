let
  pkgs = import <nixpkgs> {};
in with pkgs; {
  binutils = import ./binutils.nix {
    inherit bison fetchurl flex gettext libbfd libiberty libopcodes stdenv texinfo zlib;
  };
}

# code for section 12.7 (The inputs pattern)
{ mkDerivation, gdSupport ? true, gd, fontconfig, libjpeg, bzip2 }:

mkDerivation {
  name = "graphviz";
  #src = ./graphviz-2.38.0.tar.gz;
  src = builtins.fetchurl {
    url = "http://pkgs.fedoraproject.org/repo/pkgs/graphviz/graphviz-2.38.0.tar.gz/5b6a829b2ac94efcd5fa3c223ed6d3ae/graphviz-2.38.0.tar.gz"; 
    sha256 = "81aa238d9d4a010afa73a9d2a704fc3221c731e1e06577c2ab3496bdef67859e";
  };
  buildInputs = if gdSupport then [ gd fontconfig libjpeg bzip2 ] else [];
}

# code for section < 12.7
#let
#  pkgs = import (builtins.fetchGit {
#    name = "nixpkgs-14.12";
#    # $ git ls-remote https://github.com/nixos/nixpkgs | grep release-14.12
#    # 770822493e3962d795739fafd522e771bfe06e3d        refs/heads/release-14.12
#    # 770822493e3962d795739fafd522e771bfe06e3d        refs/remotes/origin/release-14.12
#    url = "https://github.com/nixos/nixpkgs";
#    ref = "refs/heads/release-14.12";
#    rev = "770822493e3962d795739fafd522e771bfe06e3d";
#  }) { };
#  patchedPkgs = pkgs // {"binutils-unwrapped"= "";};
#  #mkDerivation = import ./autotools.nix pkgs;
#  mkDerivation = import ./autotools.nix patchedPkgs;
#  inherit (pkgs) fetchurl;
#in mkDerivation {
#  name = "graphviz";
#  src = fetchurl {
#    url = "http://pkgs.fedoraproject.org/repo/pkgs/graphviz/graphviz-2.38.0.tar.gz/5b6a829b2ac94efcd5fa3c223ed6d3ae/graphviz-2.38.0.tar.gz"; 
#    sha256 = "81aa238d9d4a010afa73a9d2a704fc3221c731e1e06577c2ab3496bdef67859e";
#  };
#  buildInputs = with pkgs; [ gd fontconfig libjpeg bzip2 ];
#}

# code for section 12.7 (The inputs pattern)
let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
  pkgs1412 = import (builtins.fetchGit {
    name = "nixpkgs-14.12";
    # $ git ls-remote https://github.com/nixos/nixpkgs | grep release-14.12
    # 770822493e3962d795739fafd522e771bfe06e3d        refs/heads/release-14.12
    # 770822493e3962d795739fafd522e771bfe06e3d        refs/remotes/origin/release-14.12
    url = "https://github.com/nixos/nixpkgs";
    ref = "refs/heads/release-14.12";
    rev = "770822493e3962d795739fafd522e771bfe06e3d";
  }) { } // {binutils-unwrapped="";};
  mkDerivation1412 = import ./autotools.nix pkgs1412;
  libs = with pkgs1412; { inherit gd fontconfig libjpeg bzip2; };
  #fetchurl = builtins.fetchurl;
  tools = with pkgs; { inherit fetchurl; };
  #libs2 = with pkgs; { };
#in with pkgs; {
in {
  hello = import ./hello.nix ({ inherit mkDerivation; } // tools);
  #hello = import ./hello.nix { inherit mkDerivation; };
  graphviz = import ./graphviz.nix ({ mkDerivation = mkDerivation1412; } // libs);
  graphvizCore = import ./graphviz.nix (
    { mkDerivation = mkDerivation1412; gdSupport = false; } // libs
  );
}

# code for section < 12.7
#{
#  hello = import ./hello.nix; 
#  graphviz = import ./graphviz.nix;
#}

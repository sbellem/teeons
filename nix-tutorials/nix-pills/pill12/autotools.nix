pkgs: attrs:
  with pkgs;
  let defaultAttrs = {
    builder = "${bash}/bin/bash";
    args = [ ./builder.sh ];
    setup = ./setup.sh;
    baseInputs = [
      binutils
      binutils-unwrapped
      coreutils
      findutils
      gawk
      gcc
      gnugrep
      gnumake
      gnused
      gnutar
      gzip
      patchelf
    ];
    buildInputs = [];
    system = builtins.currentSystem;
  };
  in
  derivation (defaultAttrs // attrs)

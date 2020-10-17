#FROM nixpkgs/nix:nixos-20.03
FROM nixpkgs/nix@sha256:818dd239afef99a7ba0705af3de46fa093a0ef504391c2a1308283733b709b04

RUN set -ex \
        \
        && mkdir /etc/nix \
        && echo "sandbox = false" >> /etc/nix/nix.conf \
        && nix-channel --add https://nixos.org/channels/nixos-20.03 nixpkgs \
        && nix-channel --update

RUN nix-env -i /nix/store/681354n3k44r8z90m35hm8945vsp95h1-glibc-2.27

#COPY "asldobjdump.nix" "shell.nix" /usr/src/
COPY shell.nix /usr/src/

WORKDIR /usr/src
#RUN nix-build shell.nix

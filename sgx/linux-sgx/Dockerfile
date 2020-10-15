FROM nixpkgs/nix:nixos-20.03

RUN set -ex \
        \
        && mkdir /etc/nix \
        && echo "sandbox = false" >> /etc/nix/nix.conf \
        && nix-channel --add https://nixos.org/channels/nixos-20.03 nixpkgs \
        && nix-channel --update

RUN set -ex \
        && nix-env -i /nix/store/681354n3k44r8z90m35hm8945vsp95h1-glibc-2.27 \
        && nix-env -i /nix/store/1kl6ms8x56iyhylb2r83lq7j3jbnix7w-binutils-2.31.1 \
        && nix-env --set-flag priority 10 binutils-2.31.1 \
        && nix-env -i /nix/store/lvwq3g3093injr86lm0kp0f61k5cbpay-gcc-wrapper-8.3.0

COPY shell.nix /usr/src/shell.nix

WORKDIR /usr/src
RUN nix-shell

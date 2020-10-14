FROM ubuntu:18.04

RUN apt-get update \
        && apt-get install -y curl wget python perl git vim \
        && mkdir -p /nix /etc/nix \
        && chmod a+rwx /nix \
        && echo 'sandbox = false' > /etc/nix/nix.conf \
        && rm -rf /var/lib/apt/lists/*

#add a user for Nix
RUN adduser user --home /home/user --disabled-password --gecos "" --shell /bin/bash
CMD /bin/bash -l
USER user
ENV USER user
WORKDIR /home/user

#install the required software
RUN touch .bash_profile \
&& curl https://nixos.org/releases/nix/nix-2.3.7/install | sh \
&& . /home/user/.nix-profile/etc/profile.d/nix.sh

RUN git clone --recursive https://github.com/intel/linux-sgx.git /home/user/linux-sgx-z

COPY . /home/user/
#config nix-shell
#RUN . /home/user/.nix-profile/etc/profile.d/nix.sh && nix-shell

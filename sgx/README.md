# Reproducible Builds with Linux SGX
This directory's goal is to explore reproducible builds with
[linux-sgx](https://github.com/intel/linux-sgx/tree/master/linux/reproducibility).

The linux-sgx repository provides a toolchain, based on `Docker`, `Nix` and
bash scripts, to reproduce binaries that they provide. It can be a bit
confusing and slow for a newcomer to understand how to use this toolchain,
and moreover to accurately understand the precise purpose of this toolchain,
in the sense of what it does, and perhaps equally importantly what it does
not.


[nix-shell:/linux-sgx/sgxsdk/SampleCode/SampleEnclave]$ sha256sum enclave.so
7575c1127159c62ec13d6fb6d4039b9e7b1e145c68f700f0a877fe23fdb42e37  enclave.so

SIGN =>  enclave.signed.so

[nix-shell:/linux-sgx/sgxsdk/SampleCode/SampleEnclave]$ sha256sum enclave.signed.so
c2dc5ed9d5eb7bf7296d2133b6989fde2be895f0704b385e9b128bcd9a24c25f  enclave.signed.so

[nix-shell:/linux-sgx/sgxsdk/SampleCode/SampleEnclave]$ sha256sum pastenclaves/enclave.signed.so
c2dc5ed9d5eb7bf7296d2133b6989fde2be895f0704b385e9b128bcd9a24c25f  pastenclaves/enclave.signed.so


signing step:
[nix-shell:/linux-sgx/sgxsdk/SampleCode/SampleEnclave]$ /linux-sgx/sgxsdk/bin/x64/sgx_sign sign -key Enclave/Enclave_private_test.pem -enclave enclave.so -out enclave.signed.so2 -config Enclave/Enclave.config.xml

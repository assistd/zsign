#!/bin/bash

set -e

function build-mman() {
    cd mman-win32
    ./configure --cross-prefix=x86_64-w64-mingw32-
    make
    cd -
}

function build-openssl() {
    cd openssl
    git checkout OpenSSL_1_0_2s
    ./Configure --cross-compile-prefix=x86_64-w64-mingw32- mingw64
    make -j
    cd -
}

function patch-zsign() {
   cd zsign
   patch -Np1 < ../zsgin-win-mman.patch
   patch -Np1 < ../zsign-win-path.patch
   patch -Np1 < ../zsgin-linux-cmake.patch
   cd -
}

function build-zsign-win() {
    cd zsign
    x86_64-w64-mingw32-g++  *.cpp common/*.cpp -o zsign.exe \
        -I../dirent/include/ \
        -lcrypto -I../mman-win32 -std=c++11  -I../openssl/include/  -DWINDOWS -L../openssl -L../mman-win32 \
        -lmman -lgdi32 -m64 -static -static-libgcc
    cd -
}

function build-zsign-linux() {
    cd zsign
    mkdir build && cd build && cmake .. && make -j
    cd -
}


build-mman
build-openssl
patch-zsign
build-zsign-win
build-zsign-linux

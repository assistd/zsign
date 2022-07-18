cmake_minimum_required(VERSION 3.14)

project(zsign-main)
set(CMAKE_CXX_STANDARD 11)

set(MZ_BZIP2 off)
set(MZ_LZMA off)
set(MZ_ZSTD off)

add_subdirectory(zsign)
add_subdirectory(minizip-ng)
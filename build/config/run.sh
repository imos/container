#!/bin/bash

set -e -u

cd /code/build
sudo --user=cloud-admin -- \
    cmake /code/src \
        -DLLVM_CONFIG_EXECUTABLE=/usr/bin/llvm-config \
        -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
sudo --user=cloud-admin -- make

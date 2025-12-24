#!/usr/bin/env bash
set -euo pipefail
conan --version

conan profile detect --force --name default

if command -v gcc >/dev/null 2>&1 && command -v g++ >/dev/null 2>&1; then
  echo "Detecting GCC profile..."
  CC=gcc CXX=g++ conan profile detect --force --name gcc
fi

if command -v clang >/dev/null 2>&1 && command -v clang++ >/dev/null 2>&1; then
  echo "Detecting Clang profile..."
  CC=clang CXX=clang++ conan profile detect --force --name clang
fi

conan profile list

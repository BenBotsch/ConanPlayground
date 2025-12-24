#!/usr/bin/env bash
set -euo pipefail
mkdir -p locks

conan lock create apps/consumer \
  -s:h build_type=Release \
  -pr:h default \
  -pr:b default -pr:b conan-config/profiles/common \
  --lockfile-out locks/consumer_release.lock

conan lock create apps/consumer \
  -s:h build_type=Debug \
  -pr:h default \
  -pr:b default -pr:b conan-config/profiles/common \
  --lockfile-out locks/consumer_debug.lock

echo "Created lockfiles in ./locks"

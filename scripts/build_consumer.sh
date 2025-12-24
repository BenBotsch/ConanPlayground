#!/usr/bin/env bash
set -euo pipefail
pushd apps/consumer >/dev/null
conan install . -of build --build=missing -s build_type=Release -pr:b default -pr:b ../../conan-config/profiles/common
cmake --preset conan-release
cmake --build --preset conan-release
./build/consumer_app || true
popd >/dev/null

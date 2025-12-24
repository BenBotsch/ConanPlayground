#!/usr/bin/env bash
set -euo pipefail
conan create packages/hello -s build_type=Release -pr:b default -pr:b conan-config/profiles/common --build=missing
conan create packages/adder -s build_type=Release -pr:b default -pr:b conan-config/profiles/common --build=missing

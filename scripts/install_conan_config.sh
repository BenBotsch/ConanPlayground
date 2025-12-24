#!/usr/bin/env bash
set -euo pipefail
conan config install conan-config
echo "Installed conan-config. Profile 'common' is now available in cache."
conan profile list

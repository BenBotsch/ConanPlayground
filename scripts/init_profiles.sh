#!/usr/bin/env bash
set -euo pipefail
python3 -m pip install --upgrade pip >/dev/null
python3 -m pip install --upgrade conan >/dev/null
conan --version
conan profile detect --force --name default
echo "== Default profile =="
conan profile show -pr default

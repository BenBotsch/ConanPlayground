#!/usr/bin/env bash
set -euo pipefail
REMOTE_NAME="${1:-artifactory}"
conan upload "hello/0.1.0:*" -r "$REMOTE_NAME" -c
conan upload "adder/0.1.0:*" -r "$REMOTE_NAME" -c

#!/usr/bin/env bash
set -euo pipefail

: "${ARTIFACTORY_URL:?Set ARTIFACTORY_URL, e.g. https://my.jfrog.io/artifactory}"
: "${ARTIFACTORY_REPO:?Set ARTIFACTORY_REPO, e.g. conan-local}"
: "${ARTIFACTORY_USER:?Set ARTIFACTORY_USER (your Artifactory username)}"
: "${ARTIFACTORY_TOKEN:?Set ARTIFACTORY_TOKEN (access token/password)}"

REMOTE_NAME="${ARTIFACTORY_REMOTE_NAME:-artifactory}"
REMOTE_URL="${ARTIFACTORY_URL%/}/api/conan/${ARTIFACTORY_REPO}"

conan remote remove "$REMOTE_NAME" >/dev/null 2>&1 || true
conan remote add "$REMOTE_NAME" "$REMOTE_URL"
conan remote login "$REMOTE_NAME" "$ARTIFACTORY_USER" -p "$ARTIFACTORY_TOKEN"
conan remote list
echo "Artifactory remote configured: $REMOTE_NAME -> $REMOTE_URL"

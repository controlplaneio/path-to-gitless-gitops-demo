#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

podman build app \
  -t "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}" \
  -t "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}"
podman push "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
podman push "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}"

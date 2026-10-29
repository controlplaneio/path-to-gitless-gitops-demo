#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

podman build app -t "${OCI_REGISTRY}/${APP_NAME}:${APP_TAG}"
podman push "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
podman push "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}"

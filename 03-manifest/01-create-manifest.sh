#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

SIGNED_IMAGE_DIGEST=$(oras resolve "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}")
UNSIGNED_IMAGE_DIGEST=$(oras resolve "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}")

kubectl create deploy "${MANIFEST_NAME}-signed-image" \
  --image="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}@${SIGNED_IMAGE_DIGEST}" \
  --dry-run=client \
  -o yaml > "${MANIFEST_NAME}-signed-image.yaml"

kubectl create deploy "${MANIFEST_NAME}-unsigned-image" \
  --image="${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}@${UNSIGNED_IMAGE_DIGEST}" \
  --dry-run=client \
  -o yaml > "${MANIFEST_NAME}-unsigned-image.yaml"


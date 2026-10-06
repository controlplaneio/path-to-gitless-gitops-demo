#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

IMAGE="${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}"
DIGEST=$(oras resolve registry.iximiuz.com/a-simple-app:v0.1.0)

kubectl create deploy ${MANIFEST_NAME} \
  --image="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}@${DIGEST}" \
  --dry-run=client \
  -o yaml > ${MANIFEST_NAME}-signed-image.yaml

kubectl create deploy ${MANIFEST_NAME} \
  --image="${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}@${DIGEST}" \
  --dry-run=client \
  -o yaml > ${MANIFEST_NAME}-unsigned-image.yaml


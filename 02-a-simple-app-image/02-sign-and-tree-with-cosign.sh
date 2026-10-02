#!/usr/bin/env bash
set -euo pipefail

IMAGE="registry.iximiuz.com/a-simple-app"
TAG="v0.1.0"
DIGEST=$(oras resolve ${IMAGE}:${TAG})

echo "Now we sign our image with cosign, then display it."
cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"

cosign tree "${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"

echo "The unsigned image does not have any signatures"

cosign tree "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}"

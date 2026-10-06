#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

IMAGE_URL="{OCI_REGISTRY}/${APP_NAME}"
DIGEST_SIGNED=$(oras resolve ${IMAGE_URL}-signed:${TAG})

echo "Now we sign our image with cosign, then display it."
cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${IMAGE_URL}-signed:${TAG}@${DIGEST_SIGNED}"

cosign tree "${IMAGE_URL}-signed:${TAG}@${DIGEST_SIGNED}"

echo "Verify the unsigned image does not have any signatures using cosign tree"

DIGEST_UNSIGNED=$(oras resolve ${IMAGE_URL}-unsigned:${TAG})

cosign tree "${OCI_REGISTRY}/${APP_NAME}-unsigned:${APP_TAG}@${DIGEST_UNSIGNED}"

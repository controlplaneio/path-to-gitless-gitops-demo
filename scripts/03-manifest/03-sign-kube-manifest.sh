#!/bin/bash
set -o pipefail

# Use oras resolve to cleanly fetch the digest of the tag
DIGEST=$(oras resolve ${IMAGE_REPO}:${TAG})

echo "Sign OCI artifact with digest $DIGEST"

cosign sign \
  --key openbao://gitless-gitops \
  --allow-http-registry=true \
  --yes \
  "${IMAGE_REPO}@${DIGEST}"

cosign tree ${IMAGE_REPO}:${TAG}
#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

# Use oras resolve to cleanly fetch the digest of the tag
SIGNED_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}")
UNSIGNED_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}")

echo "Sign OCI artifacts with digests ${SIGNED_DIGEST} and ${UNSIGNED_DIGEST}"

cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}@${SIGNED_DIGEST}"

cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}@${UNSIGNED_DIGEST}"

echo "The signed manifest has the attestation attached to it"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}@${SIGNED_DIGEST}"

echo "The unsigned manifest does not have an attestation attached to it"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}@${UNSIGNED_DIGEST}"

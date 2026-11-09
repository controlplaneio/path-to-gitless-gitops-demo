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

echo "The signed manifests have a signature attached to them"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}@${SIGNED_DIGEST}"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}@${UNSIGNED_DIGEST}"

echo "The unsigned manifests do not have a signature attached to them"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-unsigned-manifest:${MANIFEST_TAG}@${SIGNED_DIGEST}"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-unsigned-manifest:${MANIFEST_TAG}@${UNSIGNED_DIGEST}"

#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

# Resolve the distinct digest of each of the four OCI manifest artifacts
SIGNED_IMG_SIGNED_MANIFEST_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}")
UNSIGNED_IMG_SIGNED_MANIFEST_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}")
SIGNED_IMG_UNSIGNED_MANIFEST_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-unsigned-manifest:${MANIFEST_TAG}")
UNSIGNED_IMG_UNSIGNED_MANIFEST_DIGEST=$(oras resolve "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-unsigned-manifest:${MANIFEST_TAG}")

echo "Sign OCI artifacts with digests ${SIGNED_IMG_SIGNED_MANIFEST_DIGEST} and ${UNSIGNED_IMG_SIGNED_MANIFEST_DIGEST}"

cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}@${SIGNED_IMG_SIGNED_MANIFEST_DIGEST}"

cosign sign \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}@${UNSIGNED_IMG_SIGNED_MANIFEST_DIGEST}"

echo "The signed manifests have a signature attached to them"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${MANIFEST_TAG}@${SIGNED_IMG_SIGNED_MANIFEST_DIGEST}"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${MANIFEST_TAG}@${UNSIGNED_IMG_SIGNED_MANIFEST_DIGEST}"

echo "The unsigned manifests do not have a signature attached to them"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-unsigned-manifest:${MANIFEST_TAG}@${SIGNED_IMG_UNSIGNED_MANIFEST_DIGEST}"
cosign tree "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-unsigned-manifest:${MANIFEST_TAG}@${UNSIGNED_IMG_UNSIGNED_MANIFEST_DIGEST}"

#!/bin/bash
set -o pipefail
set -o xtrace

# Use oras resolve to cleanly fetch the digest of the tag
SIGNED_DIGEST=$(oras resolve ${OCI_REGISTRY}/${MANIFEST_NAME}-signed:${TAG})
UNSIGNED_DIGEST=$(oras resolve ${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned:${TAG})

echo "Sign OCI artifact with digest $DIGEST"

cosign sign \
  --key openbao://gitless-gitops \
  --allow-http-registry=true \
  --yes \
  "${OCI_REGISTRY}/${MANIFEST_NAME}-signed:${TAG}"


echo "The signed manifest has the attestation attached to it"
cosign tree ${OCI_REGISTRY}/${MANIFEST_NAME}-signed:${TAG}@${SIGNED_DIGEST}

echo "The unsigned manifest does not have an attestation attached to it"
cosign tree ${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned:${TAG}@${UNSIGNED_DIGEST}

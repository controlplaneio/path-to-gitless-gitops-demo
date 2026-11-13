#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

echo "Applying the OCIRepository and Flux Kustomization resources - SIGNED Image SIGNED Manifest"
export ARTIFACT_NAME="${MANIFEST_NAME}-signed-image-signed-manifest"
export URL="${OCI_REGISTRY}/${ARTIFACT_NAME}"
export DIGEST=$(oras resolve "${URL}:${MANIFEST_TAG}")
envsubst < ../05-image-signature-verification/flux-ocirepo.yaml | kubectl apply -f -
envsubst < ../05-image-signature-verification/flux-kustomization.yaml | kubectl apply -f -

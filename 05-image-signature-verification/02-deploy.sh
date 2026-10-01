#!/usr/bin/env bash
set -euo pipefail

echo "Applying the OCIRepository and Flux Kustomization resources - UNSIGNED Image UNSIGNED Manifest"
export ARTIFACT_NAME="${MANIFEST_NAME}-unsigned-image-unsigned-manifest"
export URL="${OCI_REGISTRY}/${ARTIFACT_NAME}"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f
envsubst < flux-kustomization.yaml | kubectl apply -f -

echo "Applying the OCIRepository and Flux Kustomization resources - UNSIGNED Image SIGNED Manifest"
export ARTIFACT_NAME="${MANIFEST_NAME}-unsigned-image-signed-manifest"
export URL="${OCI_REGISTRY}/${ARTIFACT_NAME}"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f -
envsubst < flux-kustomization.yaml | kubectl apply -f -

echo "Applying the OCIRepository and Flux Kustomization resources - SIGNED Image UNSIGNED Manifest"
export ARTIFACT_NAME="${MANIFEST_NAME}-signed-image-unsigned-manifest"
export URL="${OCI_REGISTRY}/${ARTIFACT_NAME}"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f -
envsubst < flux-kustomization.yaml | kubectl apply -f -

echo "Applying the OCIRepository and Flux Kustomization resources - SIGNED Image SIGNED Manifest"
export ARTIFACT_NAME="${MANIFEST_NAME}-signed-image-signed-manifest"
export URL="${OCI_REGISTRY}/${ARTIFACT_NAME}"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f -
envsubst < flux-kustomization.yaml | kubectl apply -f -

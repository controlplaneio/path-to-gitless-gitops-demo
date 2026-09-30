#!/usr/bin/env bash
set -euo pipefail

IMAGE_REPO="registry.iximiuz.com/oci-deploy"
TAG="v1.0"

echo "Applying the OCIRepository and Flux Kustomization resources"

# Use oras resolve to cleanly fetch the digest of the tag
export DIGEST=$(oras resolve ${IMAGE_REPO}:${TAG})
envsubst < ocirepo.yaml | kubectl apply -f -
kubectl apply -f flux-kustomization.yaml
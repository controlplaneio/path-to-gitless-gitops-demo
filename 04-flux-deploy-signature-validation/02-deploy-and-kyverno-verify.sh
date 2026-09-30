#!/usr/bin/env bash
set -euo pipefail

# Cleanup the previous resources
kubectl delete -f flux-kustomization.yaml
kubectl delete -f flux-ocirepo.yaml

kubectl apply -f kyverno-verify-oci-artifact-signature.yaml

echo "UNSIGNED Deployment - Applying the OCIRepository and Flux Kustomization resources"
export URL="${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f - # This will fail

echo "SIGNED Deployment - Applying the OCIRepository and Flux Kustomization resources"
export URL="${OCI_REGISTRY}/${MANIFEST_NAME}-signed"
export DIGEST=$(oras resolve ${URL}:${TAG})
envsubst < flux-ocirepo.yaml | kubectl apply -f -
kubectl apply -f flux-kustomization.yaml
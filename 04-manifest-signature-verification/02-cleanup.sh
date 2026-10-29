#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

echo "Cleaning up deployed OCIRepository and Kustomization resources"
echo "Some deletions might fail depending on which steps you have executed before"

export ARTIFACT_NAME="${MANIFEST_NAME}-unsigned-image-unsigned-manifest"
kubectl delete OCIRepository ${ARTIFACT_NAME}
kubectl delete Kustomization ${ARTIFACT_NAME}

export ARTIFACT_NAME="${MANIFEST_NAME}-unsigned-image-signed-manifest"
kubectl delete OCIRepository ${ARTIFACT_NAME}
kubectl delete Kustomization ${ARTIFACT_NAME}

export ARTIFACT_NAME="${MANIFEST_NAME}-signed-image-unsigned-manifest"
kubectl delete OCIRepository ${ARTIFACT_NAME}
kubectl delete Kustomization ${ARTIFACT_NAME}

export ARTIFACT_NAME="${MANIFEST_NAME}-signed-image-signed-manifest"
kubectl delete OCIRepository ${ARTIFACT_NAME}
kubectl delete Kustomization ${ARTIFACT_NAME}


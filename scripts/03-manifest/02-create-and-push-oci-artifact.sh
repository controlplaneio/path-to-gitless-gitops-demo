#!/bin/bash
set -o pipefail
set -o xtrace

export IMAGE_REPO="registry.iximiuz.com/oci-deploy"
export TAG="v1.0"

echo "Creating the OCI artifact"

tar -czf deploy-oci.tar.gz deploy-oci.yaml

oras push "${IMAGE_REPO}:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  deploy-oci.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip
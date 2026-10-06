#!/bin/bash
set -euo pipefail
set -o xtrace

echo "Creating the OCI artifacts"

tar -czf ${MANIFEST_NAME}-signed-image.tar.gz ${MANIFEST_NAME}-signed-image.yaml

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-unsigned-manifest:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}-signed-image.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-signed-image-signed-manifest:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}-signed-image.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"

tar -czf ${MANIFEST_NAME}-unsigned-image.tar.gz ${MANIFEST_NAME}-unsigned-image.yaml

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-unsigned-manifest:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}-unsigned-image.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned-image-signed-manifest:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}-unsigned-image.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"

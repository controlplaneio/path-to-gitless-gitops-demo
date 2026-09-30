#!/bin/bash
set -o pipefail
set -o xtrace

echo "Creating the OCI artifact"

tar -czf ${MANIFEST_NAME}.tar.gz ${MANIFEST_NAME}.yaml

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-signed:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"

oras push "${OCI_REGISTRY}/${MANIFEST_NAME}-unsigned:${TAG}" \
  --artifact-type application/vnd.oci.image.manifest.v1+json \
  "${MANIFEST_NAME}.tar.gz:application/vnd.oci.image.layer.v1.tar+gzip"
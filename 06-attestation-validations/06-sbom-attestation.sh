#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

URL="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
DIGEST=$(oras resolve "${URL}")

trivy image --format spdx-json --output sbom.spdx.json ${URL}

cosign attest \
  --key openbao://gitless-gitops \
  --type spdxjson \
  --predicate sbom.spdx.json \
  "${URL}@${DIGEST}"

cosign tree ${URL}@${DIGEST}

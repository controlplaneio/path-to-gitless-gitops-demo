#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

URL="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
DIGEST=$(oras resolve "${URL}")

trivy image --format spdx-json --output sbom.spdx.json "${URL}"

cosign attest \
  --key openbao://gitless-gitops \
  --use-signing-config=false \
  --tlog-upload=false \
  --type spdxjson \
  --predicate sbom.spdx.json \
  "${URL}@${DIGEST}"

cosign tree "${URL}@${DIGEST}"

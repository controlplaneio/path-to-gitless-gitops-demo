#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

URL="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
DIGEST=$(oras resolve "${URL}")

cosign attest \
  --key openbao://gitless-gitops \
  --predicate test_result.json \
  --type https://in-toto.io/attestation/test-result/v0.1 \
  "${URL}@${DIGEST}"

cosign tree ${URL}@${DIGEST}

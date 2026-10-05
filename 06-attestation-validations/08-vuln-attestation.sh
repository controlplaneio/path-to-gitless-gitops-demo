#!/usr/bin/env bash
set -euo pipefail

URL="${OCI_REGISTRY}/${APP_NAME}-signed:${APP_TAG}"
DIGEST=$(oras resolve "${URL}")

trivy image --format cosign-vuln --output vuln.json ${URL}

cosign attest \
  --key openbao://gitless-gitops \
  --type custom \
  --predicate-type https://in-toto.io/attestation/vulns/v0.2 \
  --predicate vuln.json \
  "${URL}@${DIGEST}"

cosign tree ${URL}@${DIGEST}
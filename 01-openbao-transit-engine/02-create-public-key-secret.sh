#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

echo "Use the public key created in the last step to create a secret in the apps namespace for flux to use in validation"

kubectl -n apps create secret generic cosign-public-key \
  --from-file=cosign.pub=./cosign.pub \
  --dry-run=client -o yaml | kubectl apply -f -

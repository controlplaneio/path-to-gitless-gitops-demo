#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

kubectl apply -f kyverno-test-attestation-policy.yaml

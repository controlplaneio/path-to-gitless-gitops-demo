#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

kubectl apply -f kyverno-vuln-attestation-policy.yaml

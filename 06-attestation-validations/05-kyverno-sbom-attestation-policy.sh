#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

kubectl apply -f kyverno-sbom-attestation-policy.yaml

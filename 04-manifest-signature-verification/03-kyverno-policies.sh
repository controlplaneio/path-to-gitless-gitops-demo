#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f kyverno-verify-oci-artifact-signature.yaml

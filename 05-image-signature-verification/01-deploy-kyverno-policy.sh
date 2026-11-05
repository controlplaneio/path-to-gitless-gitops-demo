#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

kubectl apply -f image-signature-verification.yaml

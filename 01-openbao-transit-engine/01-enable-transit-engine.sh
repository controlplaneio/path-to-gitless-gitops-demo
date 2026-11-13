#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

# Enable the transit engine, and create a key at gitless-gitops
bao secrets enable transit
cosign generate-key-pair --kms openbao://gitless-gitops

#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
set -o xtrace

# Enable the transit engine if not already enabled, and create a key at gitless-gitops
secrets_list="$(bao secrets list)"
grep -q '^transit/' <<< "${secrets_list}" || bao secrets enable transit
rm -f ./cosign.pub
cosign generate-key-pair --kms openbao://gitless-gitops

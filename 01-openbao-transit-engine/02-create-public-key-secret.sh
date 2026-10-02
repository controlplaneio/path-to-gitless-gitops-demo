#!/usr/bin/env bash
set -euo pipefail

echo "Use the public key created in the last step to create a secret in the apps namespace for flux to use in validatation"

kubectl -n apps create secret generic cosign-public-key --from-file=cosign.pub=./cosign.pub
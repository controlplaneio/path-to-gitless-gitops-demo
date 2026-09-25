#!/usr/bin/env bash
set -euo pipefail

IMAGE="registry.iximiuz.com/a-simple-app"
TAG=v0.1.0
DIGEST=$(oras resolve ${IMAGE}:${TAG})

cosign attest --key openbao://gitless-gitops --predicate test_result.json --type https://in-toto.io/attestation/test-result/v0.1 ${IMAGE}@${DIGEST}
cosign tree ${IMAGE}@${DIGEST}
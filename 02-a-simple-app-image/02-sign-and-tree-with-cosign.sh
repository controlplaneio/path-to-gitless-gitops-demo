#!/usr/bin/env bash
set -euo pipefail

IMAGE="registry.iximiuz.com/a-simple-app"
TAG="v0.1.0"
DIGEST=$(oras resolve ${IMAGE}:${TAG})

echo "Now we sign our image with cosign, then display it."
cosign sign --key openbao://gitless-gitops --use-signing-config=false --tlog-upload=false $IMAGE:$TAG
cosign tree $IMAGE@$DIGEST
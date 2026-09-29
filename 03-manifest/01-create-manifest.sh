#!/usr/bin/env bash
set -euo pipefail

DIGEST=$(oras resolve registry.iximiuz.com/a-simple-app:v0.1.0)

kubectl create deploy oci-deploy \
  --image=registry.iximiuz.com/a-simple-app:v0.1.0@$DIGEST \
  --dry-run=client \
  -o yaml > deploy-oci.yaml


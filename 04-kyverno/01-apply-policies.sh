#!/bin/bash
set -o pipefail
set -o xtrace

kubectl apply -f image-verification-policy.yaml
kubectl apply -f verify-oci-repo.yaml
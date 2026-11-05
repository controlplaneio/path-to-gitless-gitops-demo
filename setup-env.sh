#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

BLOCK_START="# --- Gitless GitOps Demo Variables ---"
BLOCK_END="# --- End Gitless GitOps Demo Variables ---"

if grep -q "$BLOCK_START" ~/.bashrc; then
    echo "Variables already exist in ~/.bashrc. Skipping."
else
    cat << IN_EOF >> ~/.bashrc
$BLOCK_START
export OCI_REGISTRY="registry.iximiuz.com"
export APP_NAME="a-simple-app"
export APP_TAG="v0.1.0"
export MANIFEST_NAME="a-simple-oci-deployment"
export MANIFEST_TAG="v0.1.0"
$BLOCK_END
IN_EOF
    echo "Variables appended to ~/.bashrc"
fi

echo "Please run the following command in your terminal to apply the changes:"
echo "source ~/.bashrc"

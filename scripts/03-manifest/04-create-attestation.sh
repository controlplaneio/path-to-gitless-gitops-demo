#!/bin/bash
set -o pipefail
set -o xtrace

echo "Create test attestation"
echo "Deploying to test cluster..."
kubectl apply -f deploy-oci.yaml
kubectl wait --for=condition=available deployment/oci-deploy --timeout=60s

echo "Running integration test..."
kubectl port-forward deploy/oci-deploy 8000:8000 > /dev/null 2>&1 &
PF_PID=$!

# Give the tunnel 2 seconds to establish
sleep 2

# Execute the test on port 8000
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

# Kill the tunnel immediately after the test
kill $PF_PID

if [ "$HTTP_STATUS" == "200" ]; then
  echo "Test passed! Generating test predicate..."
  
  cat << "EOF" > test-result.json
{
  "result": "PASSED",
  "configuration": [
    {
      "name": "http-liveness-check",
      "uri": "https://local-poc/run/1"
    }
  ],
  "url": "https://local-poc/run/1",
  "passedTests": [
    "http-liveness-check"
  ],
  "warnedTests": [],
  "failedTests": []
}
EOF

echo "Attaching in-toto attestation to the registry..."


cosign attest \
  --key openbao://gitless-gitops \
  --type "https://in-toto.io/attestation/test-result/v0.1" \
  --predicate test-result.json \
  --allow-http-registry=true \
  --yes \
  "${IMAGE_REPO}@${DIGEST}"

echo "Pipeline complete! Signature and Attestation pushed to ${IMAGE_REPO}."
oras discover "${IMAGE_REPO}@${DIGEST}"

else
echo "[ERROR] Test failed with HTTP $HTTP_STATUS"
exit 1
fi


echo "[INFO] 3.4. Verifying attestation"
cosign verify-attestation \
--key openbao://gitless-gitops \
--type "https://in-toto.io/attestation/test-result/v0.1" \
--allow-http-registry=true \
"${IMAGE_REPO}@${DIGEST}" | jq '.payload | @base64d | fromjson'
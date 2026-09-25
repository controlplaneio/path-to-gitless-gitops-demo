#!/bin/bash
set -o pipefail
set -o xtrace

echo "3. Create test attestation"
echo "3.1. Deploying to test cluster..."
kubectl apply -f deploy-oci.yaml
kubectl wait --for=condition=available deployment/oci-deploy --timeout=60s

echo "3.2. Running integration test..."
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
  
  cat <<TOF > test-result.json
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
TOF

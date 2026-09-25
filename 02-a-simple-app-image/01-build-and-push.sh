#!/usr/bin/env bash
set -euo pipefail

podman build app -t registry.iximiuz.com/a-simple-app:v0.1.0
podman push registry.iximiuz.com/a-simple-app:v0.1.0

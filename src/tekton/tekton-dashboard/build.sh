#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# cd to the repo root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${REPO_ROOT}"

VERSION=${1:-}
if [[ -z "${VERSION}" ]]; then
  echo "must pass version"
  gsutil ls gs://tekton-releases/dashboard/previous/ | sed 's@gs://tekton-releases/dashboard/previous/@@g' | sed 's@/@@g'
  exit 1
fi

mkdir -p tekton/tekton-dashboard/${VERSION}/
wget https://storage.googleapis.com/tekton-releases/dashboard/previous/${VERSION}/release-full.yaml -O ${REPO_ROOT}/tekton/tekton-dashboard/${VERSION}/manifest.yaml

kpt pkg init tekton/tekton-dashboard/${VERSION} --description "tekton-dashboard"
cat > tekton/tekton-dashboard/${VERSION}/README.md <<EOF
# tekton-dashboard

## Description
tekton-dashboard is the dashboard for tekton.

https://github.com/tektoncd/dashboard
EOF
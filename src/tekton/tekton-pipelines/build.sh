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
  gsutil ls gs://tekton-releases/pipeline/previous/ | sed 's@gs://tekton-releases/pipeline/previous/@@g' | sed 's@/@@g'
  exit 1
fi

mkdir -p tekton/tekton-pipelines/${VERSION}/
wget https://storage.googleapis.com/tekton-releases/pipeline/previous/${VERSION}/release.yaml -O ${REPO_ROOT}/tekton/tekton-pipelines/${VERSION}/manifest.yaml

kpt pkg init tekton/tekton-pipelines/${VERSION} --description "tekton-pipelines"
cat > tekton/tekton-pipelines/${VERSION}/README.md <<EOF
# tekton-pipelines

## Description
tekton-pipelines is the pipelines for tekton.

https://github.com/tektoncd/pipelines
EOF
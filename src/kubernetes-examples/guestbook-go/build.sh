#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# cd to the repo root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${REPO_ROOT}"

VERSION=v3.0.20230124-kpt.1

mkdir -p kubernetes-examples/guestbook-go/${VERSION}/
# TODO: Copy from somewhere

# TODO: Run kpt function to set namespace

kpt pkg init kubernetes-examples/guestbook-go/${VERSION}/ --description "guestbook-go"
cat > kubernetes-examples/guestbook-go/${VERSION}/README.md <<EOF
# guestbook-go

## Description
guestbook-go is one of the kubernetes examples, a version of the guestbook example application written in go.

https://github.com/kubernetes/examples/tree/master/guestbook-go
EOF
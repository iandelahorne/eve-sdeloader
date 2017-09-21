#!/usr/bin/env bash
set -e

PKGS=$(go list ./... | grep -v /vendor/)
for pkg in $PKGS; do
  go test -race -coverprofile=profile.out -covermode=atomic $pkg
  if [[ -f profile.out ]]; then
    cat profile.out >> coverage.txt
    rm profile.out
  fi
done
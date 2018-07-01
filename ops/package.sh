#!/usr/bin/env bash
set -e
rm -f ./charts/index.yaml
helm package . -d ./charts
helm repo index ./charts
#!/usr/bin/env bash
set -e
helm package ./charts/webproxy/ -d ./charts
helm repo index ./charts
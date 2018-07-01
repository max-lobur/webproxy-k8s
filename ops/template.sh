#!/usr/bin/env bash
set -e
helm template charts/webproxy -f samples/ha-with-nginx-ingress.yaml --set login="$LOGIN"
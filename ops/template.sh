#!/usr/bin/env bash
set -e
helm template charts/webproxy -f samples/high-avail.yaml --set login="$LOGIN"
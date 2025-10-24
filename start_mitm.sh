#!/usr/bin/env bash
# start_mitm.sh
# Starts mitmproxy on port 8080
set -e
PORT="${1:-8080}"
if ! command -v mitmproxy >/dev/null 2>&1; then
  echo "mitmproxy not found. Install via: pip install mitmproxy"
  exit 1
fi
echo "Starting mitmproxy on port $PORT"
mitmproxy --listen-port "$PORT"

#!/usr/bin/env bash
# set_proxy_adb.sh
# Usage: ./set_proxy_adb.sh <HOST_IP> <PORT>
set -e
if [ $# -lt 2 ]; then
  echo "Usage: $0 <HOST_IP> <PORT>"
  exit 1
fi
HOST_IP="$1"
PORT="$2"

echo "Setting global http_proxy to $HOST_IP:$PORT"
adb root || true
adb wait-for-device
# Set global proxy
adb shell settings put global http_proxy "${HOST_IP}:${PORT}"
# For some Android versions you also may need to set global proxy host/port separately:
adb shell settings put global global_http_proxy_host "$HOST_IP"
adb shell settings put global global_http_proxy_port "$PORT"

echo "Proxy set. Verify with:"
adb shell settings get global http_proxy

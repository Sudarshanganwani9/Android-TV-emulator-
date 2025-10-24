#!/usr/bin/env bash
# clear_proxy_adb.sh
set -e
echo "Clearing global proxy settings"
adb shell settings put global http_proxy :0 || true
adb shell settings delete global global_http_proxy_host || true
adb shell settings delete global global_http_proxy_port || true
echo "Cleared. Verify with: adb shell settings get global http_proxy"

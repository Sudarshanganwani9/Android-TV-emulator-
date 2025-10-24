#!/usr/bin/env bash
# start_emulator.sh
set -e
if [ -z "$1" ]; then
  echo "Usage: $0 <AVD_NAME>"
  exit 1
fi
AVD_NAME="$1"
echo "Starting emulator: $AVD_NAME"
emulator -avd "$AVD_NAME" -netdelay none -netspeed full &
echo "Emulator process started. Wait for boot complete:"
echo "Use: adb wait-for-device; adb shell getprop sys.boot_completed"

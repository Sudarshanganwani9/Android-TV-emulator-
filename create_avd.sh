#!/usr/bin/env bash
# create_avd.sh
# Creates an Android TV AVD. Edit ANDROID_SDK_ROOT if needed.
set -e
ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}"
echo "Using ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"

# Ensure command-line tools are available
if ! command -v sdkmanager >/dev/null 2>&1; then
  echo "sdkmanager not found in PATH. Install Android SDK command-line tools and add to PATH."
  exit 1
fi

# Example system image and AVD name (edit if necessary)
AVD_NAME="${1:-Android_TV_1080p_API_30}"
SYSTEM_IMAGE="system-images;android-30;google_apis;x86"

echo "Installing system image (if not installed) -> $SYSTEM_IMAGE"
yes | sdkmanager --install "$SYSTEM_IMAGE"

echo "Creating AVD named: $AVD_NAME"
# Device id for Android TV (may vary). If this fails, create AVD via Android Studio.
DEVICE="tv_1080p"  # common name; adjust if avdmanager complains
echo "Using device name: $DEVICE (if invalid, open Android Studio to select correct device)"
echo no | avdmanager create avd -n "$AVD_NAME" -k "$SYSTEM_IMAGE" -d "$DEVICE" || true

echo "AVD created. Start it with: emulator -avd $AVD_NAME"

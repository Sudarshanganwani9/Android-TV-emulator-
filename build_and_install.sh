#!/usr/bin/env bash
# build_and_install.sh
# Builds the Android sample app (debug) and installs the APK onto a running emulator.
# Requirements: Android SDK (with build-tools and platform 30), Java JDK, and network access.
set -e
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)/android_sample_app"
echo "Project dir: $PROJECT_DIR"
cd "$PROJECT_DIR"
# Make gradlew executable if present
if [ -f "./gradlew" ]; then
  chmod +x ./gradlew
  ./gradlew assembleDebug
else
  echo "gradlew not found. Attempting to run 'gradle assembleDebug' using system gradle..."
  gradle assembleDebug
fi

APK_PATH=$(find "$PROJECT_DIR" -path "*/build/outputs/apk/debug/*.apk" | head -n1 || true)
if [ -z "$APK_PATH" ]; then
  echo "APK not found. Build may have failed."
  exit 1
fi
echo "Built APK: $APK_PATH"
echo "Installing to first connected device/emulator..."
adb wait-for-device
adb install -r "$APK_PATH"
echo "Installed. Launching app..."
adb shell monkey -p com.example.androidtvsample -c android.intent.category.LAUNCHER 1 || true
echo "Done."

#!/usr/bin/env bash
# gradlew - minimal script to run Gradle wrapper
DIR="$(cd "$(dirname "$0")" && pwd)"
# Use bundled wrapper if present, otherwise try to use system gradle
if [ -f "$DIR/gradle/wrapper/gradle-wrapper.jar" ]; then
  java -jar "$DIR/gradle/wrapper/gradle-wrapper.jar" "$@"
else
  echo "Gradle wrapper jar missing. Attempting to use system 'gradle' if available..."
  if command -v gradle >/dev/null 2>&1; then
    gradle "$@"
  else
    echo "No gradle found. To download wrapper, run: gradle wrapper or obtain gradle-wrapper.jar from a machine with Gradle."
    exit 1
  fi
fi

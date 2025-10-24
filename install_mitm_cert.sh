#!/usr/bin/env bash
# install_mitm_cert.sh
# Attempts to find mitmproxy's certificate, convert to DER, push to device, and trigger install.
set -e
MITM_PEM="${1:-$HOME/.mitmproxy/mitmproxy-ca-cert.pem}"
OUT_CRT="/tmp/mitmproxy-ca.crt"

if [ ! -f "$MITM_PEM" ]; then
  echo "mitmproxy cert not found at $MITM_PEM"
  echo "Start mitmproxy once and visit http://mitm.it from emulator browser to generate cert, or run mitmproxy to create it."
  exit 1
fi

echo "Converting PEM -> DER (.crt) for Android"
openssl x509 -in "$MITM_PEM" -outform DER -out "$OUT_CRT"

echo "Pushing to emulator /sdcard/"
adb wait-for-device
adb push "$OUT_CRT" /sdcard/mitmproxy-ca.crt

echo "Triggering certificate installer UI..."
adb shell am start -a android.credentials.INSTALL -n com.android.certinstaller/.CertInstallerActivity || true
echo "If install UI does not appear on Android TV, open Settings -> Security -> Install from storage and install /sdcard/mitmproxy-ca.crt"

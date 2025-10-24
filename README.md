# Task 2 — Android TV HTTPS Capture (Complete Package)

This package contains scripts, instructions and sample utilities to help you set up an **Android TV emulator**, route traffic through **mitmproxy**, and capture & decode HTTPS traffic.

**What's included**
- README.md (this file)
- scripts/
  - create_avd.sh           - (automates AVD creation; may require minor edits)
  - start_emulator.sh       - (start an AVD)
  - start_mitm.sh           - (starts mitmproxy)
  - set_proxy_adb.sh        - (set global proxy on emulator via adb)
  - clear_proxy_adb.sh      - (clear proxy)
  - install_mitm_cert.sh    - (convert and push mitmproxy cert to emulator and attempt install)
  - notes.txt               - extra notes about certificate pinning and troubleshooting
- LICENSE
- .gitignore

> **Important:** This package automates many steps but **requires** Android SDK tools (sdkmanager, avdmanager, emulator, adb) installed and on your PATH. It also expects Python + mitmproxy + openssl available on host.

---

## Quick steps (high level)

1. Install prerequisites:
   - Android Studio (or Android SDK command-line tools)
   - `sdkmanager`, `avdmanager`, `adb`, `emulator` in PATH
   - Python (3.8+)
   - `mitmproxy` (`pip install mitmproxy`)
   - `openssl` (for certificate conversion)

2. Create an Android TV AVD:
   - Run `scripts/create_avd.sh`
   - Or create via Android Studio Device Manager (choose Android TV 1080p device and a system image)

3. Start the emulator:
   - Run `scripts/start_emulator.sh <AVD_NAME>`
   - Wait until fully booted (adb devices shows it as 'device' and `adb shell getprop sys.boot_completed` returns 1)

4. Start mitmproxy on host:
   - Run `scripts/start_mitm.sh`
   - Default listen port: 8080

5. Configure emulator to proxy via ADB:
   - Run `scripts/set_proxy_adb.sh <HOST_IP> 8080`
   - (Replace `<HOST_IP>` with your machine's LAN IP visible to emulator, e.g., 192.168.1.10)

6. Install mitmproxy certificate on emulator:
   - Run `scripts/install_mitm_cert.sh`
   - Reboot emulator if necessary

7. Launch any Android TV app and observe requests in mitmproxy window.

---

## Notes about certificate pinning & protected apps
- Some apps perform certificate pinning; mitmproxy won't decrypt requests from those without bypassing pinning.
- For pinned apps you can use dynamic instrumentation tools (Frida + Frida-server) to bypass pinning — this is advanced and out-of-scope for the basic assignment.

---

## Deliverables you can capture
- Screenshots of emulator with app running
- mitmproxy terminal showing decoded HTTPS request/response
- README (this file, with small edits showing your host IP / AVD name)

## Added in full package
- Minimal Android TV sample app scaffold in `android_sample_app/` (Kotlin MainActivity)
- `scripts/env.sh` to set your ANDROID_SDK_ROOT, HOST_IP, AVD_NAME, MITM_PORT
- `scripts/adb_log_example.txt` with sample ADB commands
- Placeholder screenshots in `screenshots/`

**Note:** The sample app is a lightweight scaffold for testing deployment onto an emulator. It is not a full-featured app and may need Gradle wrapper and actual Android SDK to build.



## Build & APK notes (added)

I added Gradle wrapper helper files and a build/install script:
- `scripts/gradlew` and `scripts/gradlew.bat` : helper wrappers (may require gradle-wrapper.jar or system gradle)
- `android_sample_app/gradle/wrapper/gradle-wrapper.properties` : points to a Gradle distribution
- `scripts/build_and_install.sh` : builds the app and installs onto an emulator via adb

**Important limitations (environment here)**
- I cannot run the Android build tools in this environment, so I cannot produce the debug APK for you here.
- To build the APK locally on your machine:
  1. Install Java JDK and Android SDK (platform 30 and build-tools).
  2. From project root: `cd android_sample_app`
  3. If you have Gradle installed, run: `gradle wrapper` to create the wrapper, or let `scripts/gradlew` use your system gradle.
  4. Run `./gradlew assembleDebug` (Unix) or `gradlew.bat assembleDebug` (Windows).
  5. Or run `../scripts/build_and_install.sh` to both build and push to emulator (ensure ANDROID_SDK_ROOT and adb are available in PATH).



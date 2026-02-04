# Robot Framework + Appium POM (Android ApiDemos)

This project demonstrates a Page Object Model (POM) structure with Robot Framework and Appium for testing the openly available Android **ApiDemos** app.

## Structure

- `resources/common/` — App-level keywords and capabilities
- `resources/pages/` — Page Object keywords for screens
- `resources/procedures/` — High-level flows combining pages
- `tests/` — Smoke and functional test suites
- `apps/` — Place the `ApiDemos-debug.apk` here

## Prerequisites (Windows)

1. Python 3.10+ and pip
2. Node.js 18+ (for Appium)
3. Java JDK 11+
4. Android SDK + Platform Tools (ADB)
5. ANDROID_HOME and JAVA_HOME environment variables configured

## Install Appium (v2) and Android driver

```powershell
npm install -g appium
appium driver install uiautomator2
```

Start Appium server:

```powershell
./scripts/start-appium.ps1
```

## Download the sample app

Download the ApiDemos APK from the Appium GitHub releases and place it in `apps/`:

- https://github.com/appium/android-apidemos/releases (use `ApiDemos-debug.apk`)

Resulting path should be `apps/ApiDemos-debug.apk`.

## Python dependencies

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## Configure Android SDK environment variables (Windows)

If you installed Android Studio, the SDK is typically at `%LOCALAPPDATA%\Android\Sdk`. Set the required variables and ensure `platform-tools` is on your PATH:

```powershell
./scripts/configure-android-env.ps1
adb devices
```

If `adb devices` shows any `offline` emulators, stabilize ADB to avoid Appium proxy errors:

```powershell
./scripts/adb-stabilize.ps1
```

If no devices appear, start an emulator from Android Studio or connect a real device (USB debugging enabled).

## Run on emulator or real device

- Emulator: create an Android Virtual Device (AVD) in Android Studio and start it.
- Real device: enable USB debugging and ensure `adb devices` shows your device.

## Run tests

In one terminal, keep Appium running. In another, run Robot:

```powershell
robot -d reports tests
```

Common targeted runs:

```powershell
robot -d reports tests\smoke\test_navigation.robot
robot -d reports tests\functional\test_controls.robot
```

Target a specific real device when multiple devices are present:

```powershell
# Replace R58M510SP7A with your device's UDID
robot --variable UDID:R58M510SP7A -d reports tests\smoke\test_navigation.robot
```

Scripted runs with optional UDID:

```powershell
# Start Appium (keep this terminal open, it restarts ADB and frees port 4723)
./scripts/start-appium.ps1

# Smoke tests
# Replace R58M510SP7A with your device's UDID
robot --variable UDID:R58M510SP7A -d reports tests\smoke\test_navigation.robot

# Or via script with UDID param
./scripts/run-smoke.ps1 -Udid R58M510SP7A

# Functional tests
robot -d reports tests\functional\test_controls.robot

# Or via script with UDID param
./scripts/run-functional.ps1 -Udid R58M510SP7A
```

If you see "Second signal will force exit" or Appium logs "socket hang up", keep Appium in its own terminal and avoid interrupts while tests run. Use `./scripts/adb-stabilize.ps1` to kill offline emulators and restart ADB.

## Notes

- For Appium v2, the default base path is `/`. The project uses `http://127.0.0.1:4723` in `resources/common/app.robot`.
- If using a real device, you may need to add `udid=<device_udid>` to `Open Application` capabilities in `app.robot`.

## Troubleshooting

- "socket hang up" or screenshot warnings: keep Appium in its own terminal and start it via `./scripts/start-appium.ps1` (it restarts ADB and frees port 4723). If `adb devices` shows `offline` or `unauthorized`, run `./scripts/adb-stabilize.ps1` and accept the RSA prompt on the device.
- Avoid opening multiple Appium sessions per test. Use either `Suite Setup` or `Test Setup` to open the app, not both.
- If navigation clicks intermittently fail, increase waits or use `Wait Until Element Is Visible` before `Click Element`. Default waits are set in `Open App`.
- When multiple devices are connected, pass `--variable UDID:<device_udid>` to `robot` or use `-Udid` with the helper scripts.

<!-- Packaging instructions removed per request -->

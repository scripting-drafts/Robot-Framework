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
appium
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

## Notes

- For Appium v2, the default base path is `/`. The project uses `http://127.0.0.1:4723` in `resources/common/app.robot`.
- If using a real device, you may need to add `udid=<device_udid>` to `Open Application` capabilities in `app.robot`.

<!-- Packaging instructions removed per request -->

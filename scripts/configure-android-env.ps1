# Configures Android SDK environment variables (Windows)
# - Sets ANDROID_SDK_ROOT and ANDROID_HOME
# - Adds platform-tools to User PATH
# - Verifies adb availability

param()

$ErrorActionPreference = "Stop"

function Add-ToUserPathIfMissing($pathToAdd) {
    $currentUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ([string]::IsNullOrEmpty($currentUserPath)) { $currentUserPath = "" }
    if ($currentUserPath -notlike "*${pathToAdd}*") {
        $newUserPath = if ($currentUserPath.Trim().Length -gt 0) { "$currentUserPath;$pathToAdd" } else { $pathToAdd }
        [Environment]::SetEnvironmentVariable("Path", $newUserPath, "User")
        Write-Host "Added to User PATH: $pathToAdd"
    } else {
        Write-Host "Already in User PATH: $pathToAdd"
    }
}

# Detect SDK location
$defaultSdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$sdk = $env:ANDROID_SDK_ROOT
if (-not $sdk -or -not (Test-Path $sdk)) {
    if (Test-Path $defaultSdk) { $sdk = $defaultSdk }
}

if (-not $sdk -or -not (Test-Path $sdk)) {
    Write-Error "Android SDK not found. Install via Android Studio or set ANDROID_SDK_ROOT manually. Expected at $defaultSdk"
    exit 1
}

Write-Host "Using Android SDK at: $sdk"

# Set env vars for current session
$env:ANDROID_SDK_ROOT = $sdk
$env:ANDROID_HOME = $sdk
Write-Host "Set ANDROID_SDK_ROOT and ANDROID_HOME for current session."

# Persist env vars for user
setx ANDROID_SDK_ROOT "$sdk" | Out-Null
setx ANDROID_HOME "$sdk" | Out-Null
Write-Host "Persisted ANDROID_SDK_ROOT and ANDROID_HOME for the user."

# Ensure platform-tools on PATH
$platformTools = Join-Path $sdk "platform-tools"
if (Test-Path $platformTools) {
    Add-ToUserPathIfMissing $platformTools
    # Update current session PATH too
    if ($env:Path -notlike "*${platformTools}*") { $env:Path = "$env:Path;$platformTools" }
} else {
    Write-Warning "platform-tools folder not found at $platformTools. Ensure SDK components are installed."
}

# Verify adb
$adbExe = Join-Path $platformTools "adb.exe"
if (Test-Path $adbExe) {
    & $adbExe version
    & $adbExe devices
} else {
    Write-Warning "adb.exe not found in $platformTools"
}

Write-Host "Done. Restart terminals if PATH changes don't reflect immediately."
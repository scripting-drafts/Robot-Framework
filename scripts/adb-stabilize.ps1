# Stabilize ADB by restarting server and killing offline emulators
$repoRoot = Split-Path -Parent $PSScriptRoot
Write-Host "Configuring Android SDK environment..."
& (Join-Path $repoRoot "scripts\configure-android-env.ps1")

Write-Host "Restarting ADB server..."
adb kill-server
Start-Sleep -Seconds 1
adb start-server

Write-Host "Listing devices..."
$devicesOutput = adb devices
Write-Host $devicesOutput

# Parse offline emulators and attempt to kill them
$lines = $devicesOutput -split "`n"
$offlineIds = @()
$unauthIds = @()
foreach ($line in $lines) {
    if ($line -match "^(emulator-\d+)\s+offline") {
        $id = $Matches[1]
        $offlineIds += $id
    }
    if ($line -match "^(\S+)\s+unauthorized") {
        $id2 = $Matches[1]
        $unauthIds += $id2
    }
}

if ($offlineIds.Count -gt 0) {
    Write-Host "Found offline emulators: $($offlineIds -join ', ')"
    foreach ($id in $offlineIds) {
        try {
            Write-Host "Attempting to kill emulator $id..."
            adb -s $id emu kill
        } catch {
            Write-Warning ("Failed to kill emulator {0}: {1}" -f $id, $_)
        }
    }
    Write-Host "Re-listing devices after killing offline emulators..."
    Start-Sleep -Seconds 2
    adb devices
} else {
    Write-Host "No offline emulators detected."
}

if ($unauthIds.Count -gt 0) {
    Write-Warning ("Found unauthorized devices: {0}" -f ($unauthIds -join ', '))
    Write-Host "Attempting to reconnect USB on unauthorized devices..."
    foreach ($id in $unauthIds) {
        try {
            adb -s $id usb
            adb -s $id reconnect
        } catch {
            Write-Warning ("Failed to reconnect device {0}: {1}" -f $id, $_)
        }
    }
    Write-Warning "If devices remain 'unauthorized', unlock each device and accept the RSA fingerprint prompt, then re-run this script."
    Start-Sleep -Seconds 2
    adb devices
}

Write-Host "ADB stabilization complete."

# Downloads the ApiDemos APK into apps folder
param(
    [string]$Url = "https://github.com/appium/android-apidemos/releases/latest/download/ApiDemos-debug.apk"
)
$repoRoot = Split-Path -Parent $PSScriptRoot
$appsDir = Join-Path $repoRoot "apps"
$apkPath = Join-Path $appsDir "ApiDemos-debug.apk"
if (-not (Test-Path $appsDir)) { New-Item -ItemType Directory -Path $appsDir | Out-Null }
Write-Host "Downloading ApiDemos from $Url"
Invoke-WebRequest -Uri $Url -OutFile $apkPath
Write-Host "Saved APK to: $apkPath"
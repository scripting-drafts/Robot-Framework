# Packs the repository folder into a zip next to it
$repoRoot = Split-Path -Parent $PSScriptRoot
$zipPath = Join-Path (Split-Path -Parent $repoRoot) "robot-appium-pom.zip"
Compress-Archive -Path $repoRoot -DestinationPath $zipPath -Force
Write-Host "Packed to: $zipPath"
param(
    [string]$Udid
)

# Run all smoke suites sequentially with venv and Android SDK env configured
$repoRoot = Split-Path -Parent $PSScriptRoot
$reports = Join-Path $repoRoot "reports"
if (-not (Test-Path $reports)) { New-Item -ItemType Directory -Path $reports | Out-Null }

# Configure Android SDK env and stabilize ADB
& (Join-Path $repoRoot "scripts\configure-android-env.ps1")
& (Join-Path $repoRoot "scripts\adb-stabilize.ps1")

# Activate venv if present
$activate = Join-Path $repoRoot ".venv\Scripts\Activate.ps1"
if (Test-Path $activate) { & $activate }

# Build common Robot args
$commonArgs = @('-m','robot','-d', $reports)
if ($Udid -and $Udid.Trim().Length -gt 0) { $commonArgs += @('--variable', "UDID:$Udid") }

# List of smoke suites
$suites = @(
    (Join-Path $repoRoot "tests\smoke\test_main_menu.robot"),
    (Join-Path $repoRoot "tests\smoke\test_navigation.robot"),
    (Join-Path $repoRoot "tests\smoke\test_preference.robot"),
    (Join-Path $repoRoot "tests\smoke\test_views.robot"),
    (Join-Path $repoRoot "tests\smoke\test_views_lists.robot"),
    (Join-Path $repoRoot "tests\smoke\test_views_widgets.robot")
)

$failures = @()
foreach ($suite in $suites) {
    Write-Host "Running suite: $suite"
    $args = $commonArgs + $suite
    python @args
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Suite failed: $suite"
        $failures += $suite
    }
    Start-Sleep -Seconds 2
}

if ($failures.Count -gt 0) {
    Write-Warning "Failures detected in suites:" 
    $failures | ForEach-Object { Write-Warning " - $_" }
    exit 1
} else {
    Write-Host "All smoke suites passed. Reports in $reports"
}

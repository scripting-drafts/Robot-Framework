param(
	[string]$Udid
)

# Runs functional tests with venv and Android SDK env configured
$repoRoot = Split-Path -Parent $PSScriptRoot
$reports = Join-Path $repoRoot "reports"
if (-not (Test-Path $reports)) { New-Item -ItemType Directory -Path $reports | Out-Null }

# Configure Android SDK env
& (Join-Path $repoRoot "scripts\configure-android-env.ps1")

# Activate venv if present
$activate = Join-Path $repoRoot ".venv\Scripts\Activate.ps1"
if (Test-Path $activate) { & $activate }

# Build Robot args
$suitePath = Join-Path $repoRoot "tests\functional\test_controls.robot"
$robotArgs = @('-m','robot','-d', $reports)
if ($Udid -and $Udid.Trim().Length -gt 0) { $robotArgs += @('--variable', "UDID:$Udid") }
$robotArgs += $suitePath

# Run via Python module to ensure correct interpreter
python @robotArgs

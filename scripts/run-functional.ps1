# Runs functional tests
$repoRoot = Split-Path -Parent $PSScriptRoot
$reports = Join-Path $repoRoot "reports"
if (-not (Test-Path $reports)) { New-Item -ItemType Directory -Path $reports | Out-Null }
robot -d $reports (Join-Path $repoRoot "tests\functional\test_controls.robot")

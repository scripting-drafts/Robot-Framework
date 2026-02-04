# Creates Python venv and installs requirements
$repoRoot = Split-Path -Parent $PSScriptRoot
$venvPath = Join-Path $repoRoot ".venv"
Write-Host "Creating venv at $venvPath"
python -m venv $venvPath
$activate = Join-Path $venvPath "Scripts\Activate.ps1"
Write-Host "Activating venv"
& $activate
Write-Host "Installing requirements"
pip install -r (Join-Path $repoRoot "requirements.txt")
Write-Host "Done. Remember to activate venv before running tests."
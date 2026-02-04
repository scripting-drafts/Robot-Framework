# Opens the repository folder in VS Code
$repoRoot = Split-Path -Parent $PSScriptRoot
$codeCmd = "code"
if (Get-Command $codeCmd -ErrorAction SilentlyContinue) {
  & $codeCmd $repoRoot
} else {
  $codeFallback = Join-Path $Env:LOCALAPPDATA "Programs\Microsoft VS Code\bin\code.cmd"
  if (Test-Path $codeFallback) {
    & $codeFallback $repoRoot
  } else {
    Write-Warning "VS Code CLI not found. Open the folder manually: $repoRoot"
  }
}

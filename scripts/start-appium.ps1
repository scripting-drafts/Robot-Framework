# Starts the Appium server with Android SDK env configured
$repoRoot = Split-Path -Parent $PSScriptRoot
Write-Host "Stabilizing ADB and Android SDK environment..."
& (Join-Path $repoRoot "scripts\adb-stabilize.ps1")

# Ensure port 4723 is free
$port = 4723
$conns = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
if ($conns) {
	$pids = $conns | Select-Object -ExpandProperty OwningProcess | Sort-Object -Unique
	Write-Host ("Freeing port {0} from PIDs: {1}" -f $port, ($pids -join ','))
	foreach ($p in $pids) {
		try { Stop-Process -Id $p -Force -ErrorAction Stop; Write-Host ("Stopped PID {0}" -f $p) } catch { Write-Warning ("Failed to stop PID {0}: {1}" -f $p, $_) }
	}
}

Write-Host "Starting Appium server..."
try {
	$proc = Start-Process -FilePath "powershell" -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command appium' -WindowStyle Normal -PassThru
	Write-Host ("Appium started in a separate PowerShell. PID: {0}" -f $proc.Id)
} catch {
	Write-Error ("Failed to start Appium: {0}" -f $_)
}

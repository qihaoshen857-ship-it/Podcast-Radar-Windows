param(
    [switch]$IncludeBuildTools
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

if (-not (Get-Command py -ErrorAction SilentlyContinue) -and -not (Get-Command python -ErrorAction SilentlyContinue)) {
    throw "Python 3.11-3.13 x64 is required. Install it from python.org first."
}

if (Get-Command py -ErrorAction SilentlyContinue) {
    & py -3 -m venv .venv
} else {
    & python -m venv .venv
}

$Python = Join-Path $Root ".venv\Scripts\python.exe"
& $Python -m pip install --upgrade pip wheel
$Requirements = if ($IncludeBuildTools) { "requirements-build-windows.txt" } else { "requirements.txt" }
& $Python -m pip install -r $Requirements
& (Join-Path $Root "tools\prepare_windows_runtime.ps1")

Write-Host ""
Write-Host "Setup complete. Run run_windows.cmd to start Podcast Radar." -ForegroundColor Green

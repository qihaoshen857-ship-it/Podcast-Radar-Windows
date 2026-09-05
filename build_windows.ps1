param(
    [switch]$SkipTests
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

& (Join-Path $Root "setup_windows.ps1") -IncludeBuildTools
$Python = Join-Path $Root ".venv\Scripts\python.exe"

if (-not $SkipTests) {
    & $Python -m pytest -q
    if ($LASTEXITCODE -ne 0) { throw "Tests failed with exit code $LASTEXITCODE" }
    $SourceCheck = Join-Path $env:TEMP "podcast-radar-source-ui-check.json"
    & $Python main.py --ui-smoke-check $SourceCheck
    if ($LASTEXITCODE -ne 0) {
        if (Test-Path $SourceCheck) { Get-Content $SourceCheck }
        throw "Source UI smoke check failed with exit code $LASTEXITCODE"
    }
}

& $Python (Join-Path $Root "tools\generate_windows_icon.py")

if (Test-Path "dist_windows") { Remove-Item -Recurse -Force "dist_windows" }
if (Test-Path ".pyinstaller_work") { Remove-Item -Recurse -Force ".pyinstaller_work" }

$PyInstallerArgs = @(
    "--noconfirm",
    "--clean",
    "--windowed",
    "--onedir",
    "--name", "Podcast Radar",
    "--icon", "assets\PodcastRadar.ico",
    "--distpath", "dist_windows",
    "--workpath", ".pyinstaller_work",
    "--specpath", ".",
    "--add-data", "modules;modules",
    "--add-data", "assets;assets",
    "--add-binary", ".runtime\bin\ffmpeg.exe;.runtime\bin",
    "--add-binary", ".runtime\bin\ffprobe.exe;.runtime\bin",
    "--add-binary", ".runtime\bin\deno.exe;.runtime\bin",
    "--collect-all", "yt_dlp",
    "--collect-all", "faster_whisper",
    "--collect-all", "ctranslate2",
    "--collect-all", "silero_vad",
    "--collect-data", "certifi",
    "main.py"
)
& $Python -m PyInstaller @PyInstallerArgs
if ($LASTEXITCODE -ne 0) { throw "PyInstaller failed with exit code $LASTEXITCODE" }

$ReleaseDir = Join-Path $Root "release_windows"
if (Test-Path $ReleaseDir) { Remove-Item -Recurse -Force $ReleaseDir }
New-Item -ItemType Directory -Force -Path $ReleaseDir | Out-Null

$Portable = Join-Path $ReleaseDir "PodcastRadar-Portable-0.4.45-x64.zip"
Compress-Archive -Path "dist_windows\Podcast Radar\*" -DestinationPath $Portable -CompressionLevel Optimal

$Iscc = Get-Command ISCC.exe -ErrorAction SilentlyContinue
if (-not $Iscc) {
    $Candidates = @(
        "$env:ProgramFiles(x86)\Inno Setup 6\ISCC.exe",
        "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
    )
    $IsccPath = $Candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $IsccPath) { throw "Inno Setup 6 is required to build the installer." }
} else {
    $IsccPath = $Iscc.Source
}
& $IsccPath "installer\PodcastRadar.iss"
if ($LASTEXITCODE -ne 0) { throw "Inno Setup failed with exit code $LASTEXITCODE" }

$HashFile = Join-Path $ReleaseDir "SHA256SUMS.txt"
Get-ChildItem $ReleaseDir -File | Where-Object { $_.Name -ne "SHA256SUMS.txt" } | ForEach-Object {
    $Hash = (Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    "$Hash  $($_.Name)"
} | Set-Content -Path $HashFile -Encoding ascii

Write-Host "Windows packages are ready in $ReleaseDir" -ForegroundColor Green

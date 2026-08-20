$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$RuntimeBin = Join-Path $Root ".runtime\bin"
$DownloadDir = Join-Path $Root ".build-runtime"
New-Item -ItemType Directory -Force -Path $RuntimeBin, $DownloadDir | Out-Null

$Ffmpeg = Join-Path $RuntimeBin "ffmpeg.exe"
$Ffprobe = Join-Path $RuntimeBin "ffprobe.exe"
if (-not (Test-Path $Ffmpeg) -or -not (Test-Path $Ffprobe)) {
    $Archive = Join-Path $DownloadDir "ffmpeg-win64.zip"
    $Extract = Join-Path $DownloadDir "ffmpeg"
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip" -OutFile $Archive
    if (Test-Path $Extract) { Remove-Item -Recurse -Force $Extract }
    Expand-Archive -Path $Archive -DestinationPath $Extract -Force
    $FfmpegSource = Get-ChildItem $Extract -Recurse -Filter ffmpeg.exe | Select-Object -First 1
    $FfprobeSource = Get-ChildItem $Extract -Recurse -Filter ffprobe.exe | Select-Object -First 1
    if (-not $FfmpegSource -or -not $FfprobeSource) { throw "FFmpeg archive is incomplete." }
    Copy-Item $FfmpegSource.FullName $Ffmpeg -Force
    Copy-Item $FfprobeSource.FullName $Ffprobe -Force
}

$Deno = Join-Path $RuntimeBin "deno.exe"
if (-not (Test-Path $Deno)) {
    $Archive = Join-Path $DownloadDir "deno-win64.zip"
    $Extract = Join-Path $DownloadDir "deno"
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/denoland/deno/releases/latest/download/deno-x86_64-pc-windows-msvc.zip" -OutFile $Archive
    if (Test-Path $Extract) { Remove-Item -Recurse -Force $Extract }
    Expand-Archive -Path $Archive -DestinationPath $Extract -Force
    Copy-Item (Join-Path $Extract "deno.exe") $Deno -Force
}

Write-Host "Windows runtime ready: $RuntimeBin" -ForegroundColor Green

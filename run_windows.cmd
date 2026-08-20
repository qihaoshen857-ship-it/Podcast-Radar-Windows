@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo Please run setup_windows.cmd first.
  pause
  exit /b 1
)
".venv\Scripts\python.exe" main.py

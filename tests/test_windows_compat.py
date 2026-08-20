from pathlib import Path

import main
from app import person_monitor_service


def test_frozen_windows_app_dir_uses_local_app_data(monkeypatch, tmp_path: Path) -> None:
    monkeypatch.setattr(main.sys, "frozen", True, raising=False)
    monkeypatch.setattr(main.platform, "system", lambda: "Windows")
    monkeypatch.setenv("LOCALAPPDATA", str(tmp_path))
    assert main.resolve_app_dir() == tmp_path / "PodcastRadar"


def test_person_monitor_windows_data_dir_uses_local_app_data(monkeypatch, tmp_path: Path) -> None:
    monkeypatch.setattr(person_monitor_service.platform, "system", lambda: "Windows")
    monkeypatch.setenv("LOCALAPPDATA", str(tmp_path))
    assert person_monitor_service.person_monitor_data_dir() == tmp_path / "PodcastRadar" / "person-monitor"


def test_windows_browser_detection_finds_standard_install(monkeypatch, tmp_path: Path) -> None:
    local_app_data = tmp_path / "Local"
    chrome = local_app_data / "Google" / "Chrome" / "Application" / "chrome.exe"
    chrome.parent.mkdir(parents=True)
    chrome.touch()
    monkeypatch.setattr(main.platform, "system", lambda: "Windows")
    monkeypatch.setenv("LOCALAPPDATA", str(local_app_data))
    monkeypatch.setenv("PROGRAMFILES", str(tmp_path / "Program Files"))
    monkeypatch.setenv("PROGRAMFILES(X86)", str(tmp_path / "Program Files x86"))
    monkeypatch.setattr(main.shutil, "which", lambda _command: None)
    assert main.browser_is_available("chrome") is True

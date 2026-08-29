import ast
from pathlib import Path

import main


REPO_ROOT = Path(__file__).resolve().parents[1]
TEXT_SOURCE_SUFFIXES = {".py", ".ps1", ".yml", ".yaml", ".iss"}
UNSUPPORTED_CURSOR = "pointing" + "hand"


def test_clickable_cursor_is_supported_by_windows_tk() -> None:
    assert main.CLICKABLE_CURSOR == "hand2"


def test_repository_does_not_reference_unsupported_tk_cursor() -> None:
    offenders = []
    for path in REPO_ROOT.rglob("*"):
        if not path.is_file() or ".git" in path.parts or path.suffix not in TEXT_SOURCE_SUFFIXES:
            continue
        if UNSUPPORTED_CURSOR in path.read_text(encoding="utf-8", errors="ignore"):
            offenders.append(path.relative_to(REPO_ROOT).as_posix())
    assert offenders == []


def test_tk_cursor_keywords_use_platform_safe_cursor() -> None:
    tree = ast.parse((REPO_ROOT / "main.py").read_text(encoding="utf-8"))
    cursor_values = [
        keyword.value
        for node in ast.walk(tree)
        if isinstance(node, ast.Call)
        for keyword in node.keywords
        if keyword.arg == "cursor"
    ]
    assert len(cursor_values) == 5
    assert all(
        isinstance(value, ast.Name) and value.id == "CLICKABLE_CURSOR"
        for value in cursor_values
    )


def test_windows_release_version_is_synchronized() -> None:
    expected_version = main.APP_VERSION
    expected_names = {
        "build_windows.ps1": f"PodcastRadar-Portable-{expected_version}-x64.zip",
        "installer/PodcastRadar.iss": f'#define MyAppVersion "{expected_version}"',
        ".github/workflows/build-windows.yml": f"PodcastRadar-Setup-{expected_version}-x64.exe",
        "WINDOWS_RELEASE_NOTES.md": f"Podcast Radar for Windows v{expected_version}",
        "README.md": f"Podcast Radar v{expected_version}",
    }
    for relative_path, expected_text in expected_names.items():
        content = (REPO_ROOT / relative_path).read_text(encoding="utf-8")
        assert expected_text in content, relative_path

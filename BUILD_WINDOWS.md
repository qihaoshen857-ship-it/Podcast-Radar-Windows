# Windows 构建说明

## 环境

- Windows 10/11 x64
- Python 3.13 x64
- Inno Setup 6（只在生成安装包时需要）

## 本地运行源码

双击 `setup_windows.cmd`，完成后运行 `run_windows.cmd`。

PowerShell 等价命令：

```powershell
.\setup_windows.ps1
.\.venv\Scripts\python.exe .\main.py
```

## 生成安装包

安装 Inno Setup 6 后运行：

```powershell
.\build_windows.ps1
```

脚本会：

1. 安装 Python 依赖和 PyInstaller；
2. 下载 Windows 版 FFmpeg、ffprobe 与 Deno；
3. 运行测试；
4. 生成 onedir 应用和 Portable ZIP；
5. 使用 Inno Setup 生成安装程序；
6. 输出 `SHA256SUMS.txt`。

产物位于 `release_windows`。

## GitHub Actions

推送到 `main` 会在 `windows-latest` 上构建并执行安装后自检。推送 `v*-win.*` 标签时，工作流还会自动创建 GitHub Release，避免在本地上传大文件。

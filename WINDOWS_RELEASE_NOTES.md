# Podcast Radar for Windows v0.4.43

这是 Podcast Radar 的 Windows 11 启动兼容性紧急修复版。Mac 版本不受影响。

## 本次修复

- 修复启动阶段 `_tkinter.TclError: bad cursor spec "pointinghand"`，全部可点击控件统一使用 Windows/Tk 支持的 `hand2` cursor。
- Windows CI 在静默安装后运行实际 EXE，完整初始化 Tk 与主界面、执行 `update_idletasks`，再安全退出。
- 发布自检文件同时记录运行时依赖、Tk UI 初始化和安全退出结果。

## 下载选择

- `PodcastRadar-Setup-0.4.43-x64.exe`：推荐安装包。
- `PodcastRadar-Portable-0.4.43-x64.zip`：免安装版，完整解压后运行。
- `SHA256SUMS.txt`：下载后校验文件完整性。

## 主要功能

- AI、AI 创业、天气、养生等播客主题雷达。
- Dylan Patel、Elon Musk 人物访谈监控与转录入口。
- 本地 Whisper 优先，也可填写自己的阿里云 DashScope API Key 使用云端 ASR。
- 英文标题自动汉化、中文纪要、完整译文和深度阅读页。
- 任务进度、重试提示与滑板小恐龙加载动画。

## Windows 说明

- 支持 Windows 10/11 x64。
- 应用数据位于 `%LOCALAPPDATA%\PodcastRadar`。
- 当前测试版没有商业代码签名，首次运行可能出现 SmartScreen 提示。请只从本 Release 下载并核对 SHA-256。
- 本地 Whisper 首次使用会下载模型，需要一定等待时间和磁盘空间。

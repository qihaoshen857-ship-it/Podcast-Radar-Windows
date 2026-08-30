# Podcast Radar for Windows v0.4.44

这是 Podcast Radar 的 Windows 节目卡片排版修复版。即使没有配置标题翻译 API，长英文标题也能稳定显示。

## 本次优化

- 未翻译的英文标题最多显示两行，超出部分使用省略号，不再挤进简介区域。
- 已翻译节目采用“中文主标题 + 一行浅灰英文原题”，保留原始语义线索。
- 自动删除 RSS 简介开头重复出现的节目标题，避免视觉上像两行标题叠在一起。
- 卡片高度和标题间距重新分配，并根据窗口实际宽度动态计算折行。
- 鼠标停留在标题上可查看完整中文标题和英文原题。
- 保留 v0.4.43 的 Windows 11 cursor 启动修复与安装后真实 UI 自检。

## 下载选择

- `PodcastRadar-Setup-0.4.44-x64.exe`：推荐安装包。
- `PodcastRadar-Portable-0.4.44-x64.zip`：免安装版，完整解压后运行。
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

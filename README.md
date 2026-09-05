# Podcast Radar for Windows

Podcast Radar 是一款面向研究和深度阅读的桌面播客工具。它会发现 AI、AI 创业、具身智能、天气、养生等主题的新节目，也能跟踪 Dylan Patel、Elon Musk 等人物访谈，并把值得看的音频整理成中文研究材料。

Windows 版与 Mac 版共用同一套核心功能，转录默认采用**本地 Whisper 优先**；如果你更看重速度，也可以在设置中填写自己的阿里云 DashScope API Key，切换到云端 ASR。

第一次打开应用会直接提示配置翻译服务。可使用自己的阿里云百炼或 DeepSeek API Key；如果选择稍后配置，节目发现和本地 Whisper 仍可使用，中文标题、研究纪要和全文译文会在配置后开放。

## 下载安装

请到 [Releases](https://github.com/qihaoshen857-ship-it/Podcast-Radar-Windows/releases) 下载最新版本：

- `PodcastRadar-Setup-*-x64.exe`：推荐，按向导安装。
- `PodcastRadar-Portable-*-x64.zip`：免安装，解压后运行 `Podcast Radar.exe`。

目前安装包尚未购买商业代码签名证书。Windows 首次运行时可能显示 SmartScreen 提示，请确认文件来自本仓库的 Release，并核对同页 `SHA256SUMS.txt` 后再运行。

## 第一次使用

1. 打开 Podcast Radar，在首次弹窗中选择阿里云百炼或 DeepSeek，并填写自己的 API Key；也可选择稍后配置。
2. 进入“今日雷达”，选择“综合 / AI / AI 创业 / 机器人 / 天气 / 养生”，点击刷新获取最新节目。
3. 选择节目后，可下载音频、转录、生成中文纪要或完整译文。
4. 本地 Whisper 首次转录会下载模型，等待时间会比后续更长。
5. 应用数据保存在 `%LOCALAPPDATA%\PodcastRadar`，卸载应用不会自动删除你的研究资料。

详细操作见 [WINDOWS_GUIDE.md](WINDOWS_GUIDE.md)，自行构建见 [BUILD_WINDOWS.md](BUILD_WINDOWS.md)。

## 转录模型与 API

### 本地 Whisper（默认）

无需 API Key。程序使用 `faster-whisper` 在本机完成 ASR，音频不会因为转录而上传到第三方。速度取决于 CPU、音频长度和模型首次下载状态。

### 阿里云 ASR（可选）

在“设置”中填写自己的 DashScope API Key，并选择“极速云端”。Key 只写入本机 `%LOCALAPPDATA%\PodcastRadar\.env`，不会提交到 GitHub。

### 中文译文与研究纪要

中文译文、中文标题和研究纪要可使用用户自行配置的阿里云百炼或 DeepSeek 模型服务。DeepSeek 不提供本应用的音频 ASR，选择它时音频仍由本地 Whisper 转录。未配置当前服务的 Key 时，节目发现和本地转录仍可使用。

## 隐私与费用

- 本地 Whisper 不产生云端 ASR 费用。
- 使用阿里云 ASR、翻译、纪要或 DeepSeek 翻译与纪要时，费用由你自己的服务账户承担。
- 本仓库不包含任何开发者或用户的 API Key、浏览器 Cookie、下载音频和私人研究资料。

## 版本

当前 Windows 版为 Podcast Radar v0.4.45。新增具身智能独立栏目，追踪人形机器人、模型、零部件和量产应用；保留长英文标题两行显示、简介去重、完整标题提示与 Windows 11 启动修复。详见 [栏目与评分说明](docs/EMBODIED_INTELLIGENCE.md)。

## License

项目代码采用 [MIT License](LICENSE)。第三方组件许可见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

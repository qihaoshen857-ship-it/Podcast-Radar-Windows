#define MyAppName "Podcast Radar"
#define MyAppVersion "0.4.45"
#define MyAppExeName "Podcast Radar.exe"

[Setup]
AppId={{971D7C38-7DBA-4D5A-A877-01BF05EF7591}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=Podcast Radar
DefaultDirName={localappdata}\Programs\Podcast Radar
DefaultGroupName=Podcast Radar
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\release_windows
OutputBaseFilename=PodcastRadar-Setup-{#MyAppVersion}-x64
SetupIconFile=..\assets\PodcastRadar.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加选项："; Flags: unchecked

[Files]
Source: "..\dist_windows\Podcast Radar\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Podcast Radar"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Podcast Radar"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "启动 Podcast Radar"; Flags: nowait postinstall skipifsilent

Add-WindowsCapability -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Online
Add-WindowsCapability -Name Tools.Graphics.DirectX~~~~0.0.1.0 -Online
Add-WindowsCapability -Name NetFX3~~~~ -Online
Add-WindowsCapability -Name Msix.PackagingTool.Driver~~~~0.0.1.0 -Online
Add-WindowsCapability -Name Browser.InternetExplorer~~~~0.0.11.0 -Online
Install-WindowsFeature -Name Remote-Desktop-Services, EnhancedStorage, File-Services, FS-FileServer

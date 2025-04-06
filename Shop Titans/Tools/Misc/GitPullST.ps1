$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-Location $PSScriptRoot
git checkout -- .
git pull
$mainScript=(Get-Item ..\..\Automation\Main.ahk).FullName
Start-Process($mainScript)
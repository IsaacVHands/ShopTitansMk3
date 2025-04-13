$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-Location "$PSScriptRoot\..\..\"
git checkout -- .
git pull
$mainScript=(Get-Item ..\..\Automation\Main.ahk).FullName
Start-Process($mainScript)

$stmlLocation="$PSScriptRoot\..\..\shop_titans_ml"
if(Test-Path $stmlLocation)
{
    git -C $stmlLocation pull
}
else
{
    git clone https://github.com/arhands/shop_titans_ml.git $stmlLocation
}
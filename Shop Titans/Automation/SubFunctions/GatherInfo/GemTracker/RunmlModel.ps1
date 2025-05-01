$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-Location "$PSScriptRoot\shop_titans_ml"
uv run eval_forest.py -i "$PSScriptRoot\coord.txt" | Out-File "$PSScriptRoot\mlOutput.txt" -Encoding "utf8" 
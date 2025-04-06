#Requires AutoHotkey v2.0

{
    Run("powershell -File Tools\Misc\GitPullST.ps1")
    Run("Tools\Misc\KillAllScriptsWithK.ahk")
}
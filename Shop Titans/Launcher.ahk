#Requires AutoHotkey v2.0

{
    RunWait("powershell -File Tools\Misc\GitPullST.ps1")
    Run("Tools\Misc\KillAllScriptsWithK.ahk")
    if(!FileExist("Config.txt"))
    {
        FileCopy("Config.Example.txt", "Config.txt")
    }
}
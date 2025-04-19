#Requires AutoHotkey v2.0
#include lib\helpers.ahk

{
    RunWait("powershell -File Tools\Misc\GitPullST.ps1")
    Run("Tools\Misc\KillAllScriptsWithK.ahk")
    if(!FileExist("Config.txt"))
    {
        FileCopy("Config.Example.txt", "Config.txt")
    }
}
CompareConfig()
{
    configFile := getMainDir() "/Shop Titans/Config.txt"
    configFileExample := getMainDir() "/Shop Titans/Config.txt"
    b := 0
    loop read configFile
    {
        if(GetFileLine(configFileExample, b) " :" == LTrim(RTrim(A_LoopReadLine, "= true" "= false"), ' `t'))
        {
            /*mode := LTrim(RTrim(A_LoopReadLine, " "), GetFileLine(configFileExample, b) " :")
            switch(mode)
            {
                case "= true":
                    return true
                case "= false":
                    return false
                default:
                    MsgBox("Error: config status not found")
            }*/
        }
        else
        {
            MsgBox(GetFileLine(configFileExample, b) " " A_LoopReadLine)
        }
    }
    ;MsgBox("Error: config does not exist: " configInquiry)             ;uncomment this line for debbuging 
    return false
}
GetFileLine(fileAddress, lineNum)
{
    a := 0
    loop read fileAddress
    {
        if(a == lineNum)
            return A_LoopReadLine
        a++
    }
}
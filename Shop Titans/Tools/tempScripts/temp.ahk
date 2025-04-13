#Requires AutoHotkey v2.0

{
    MsgBox(FileRead(getMainDir() "/Shop Titans/Config.txt"))
}


getMainDir()
{
    dots := "/"
    scanPos := A_ScriptDir dots ".gitignore"
    a := true
    
    while(a)
    {
        if(FileExist(scanPos))
        {
            return A_ScriptDir dots
        }
        else
        {
            dots := dots "../"
            scanPos := A_ScriptDir dots ".gitignore"
        }
    }
}
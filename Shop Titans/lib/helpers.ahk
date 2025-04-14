#Requires AutoHotkey v2.0

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
    Sleep(10)
}

GetStoredInfo(fileName, returnType)
{
    targetFile := getMainDir() "/Shop Titans/Automation/InfoBroker/" fileName
    if(!fileExist(targetFile))
    {
        FileAppend("", targetFile)
    }
    switch(StrLower(returnType))
    {
        case "bool":
            info := ""
            info := FileRead(targetFile)
            if(info == "true")
                return true
            else
                return false
        case "int":
            num := 0
            num := FileRead(targetFile)
            if(num == "")
                return 0
            else
                return num
        default:
            MsgBox("Error: return type not found")
    }
}

WriteToInfoStorage(fileName, data)
{
    targetFile := getMainDir() "/Shop Titans/Automation/InfoBroker/" fileName
    if(FileExist(targetFile))
    {

    }
    FileAppend(data, targetFile)
}

PixelCompareColor(x, y, color)
{
    if(PixelGetColor(x, y) == color)
    {
        return true
    }
    else
        return false
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

CheckConfig(configInquiry)
{
    configFile := getMainDir() "/Shop Titans/Config.txt"
    
    loop read configFile
    {
        if(configInquiry " :" == LTrim(RTrim(A_LoopReadLine, "= true" "= false"), ' `t'))
        {
            mode := LTrim(RTrim(A_LoopReadLine, " "), configInquiry " :")
            switch(mode)
            {
                case "= true":
                    return true
                case "= false":
                    return false
                default:
                    MsgBox("Error: config status not found")
            }
        }
    }
    MsgBox("Error: config does not exist")
    return false
}
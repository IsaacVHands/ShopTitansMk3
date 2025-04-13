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
    targetFile := A_ScriptDir "\InfoBroker\" fileName
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
    targetFile := A_ScriptDir "\InfoBroker\" fileName
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
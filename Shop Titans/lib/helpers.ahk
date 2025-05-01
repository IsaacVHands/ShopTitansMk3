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
            if(num == "" or type(num) != "integer")
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
        FileErase(targetFile)
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
            return StrReplace(A_ScriptDir, '\', '/') dots
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
    ;MsgBox("Error: config does not exist: " configInquiry)             ;uncomment this line for debbuging 
    return false
}

FileErase(path)
{
    FileDelete(path)
    Sleep(500)
    FileAppend("", path)
}

CheckEnergyLevel(fillPercent)       ;Note, scan maxes out at 96% and has a margin of error of around 5 percent
{
    barStart := 1388
    barEnd := 1511
    barLength := barEnd - barStart
    scan := barStart
    counter := 0
    global energyLevel

    loop barLength
    {
        ;MouseMove(scan, 25)
        if(PixelCompareColor(scan, 25, 0xFE5D36))
        {
            energyLevel := ((3 + counter)/barLength)
        }
        scan++
        counter++
    }
    if(energyLevel >= fillPercent)
        return true
    ;else
    ;    MsgBox(energyLevel)
}

EventChampionAtDoor()
{
    if(PixelSearch(&pX, &pY, 20, 961, 35, 979, 0x454545, 2) and PixelSearch(&pX, &pY, 521, 924, 539, 949, 0x3A3A3A, 2))       ;checks for the city and destign tab(if they are grayed out)
    {
        ClickAtCoord(960, 560)      ;click champion bubble
        loop(20)
        {
            if(PixelSearch(&pX, &pY, 74, 883, 174, 932, 0xEFE7D3, 1) and PixelSearch(&pX, &pY,898, 836, 984, 906, 0xEFE7D3, 1) and PixelSearch(&pX, &pY, 1689, 860, 1804, 930, 0xEFE7D3, 1))
            {
                ClickAtCoord(930, 889)      ;click through the diolog
            }
            Sleep(250)
        }
        RunFromTopDir("Shop Titans/Automation/SubFunctions/General/ReturnToDefaultPos.ahk")
    }
}

RunFromTopDir(path)
{
    absolutePath := getMainDir() "/" path
    RunWait(absolutePath)
}
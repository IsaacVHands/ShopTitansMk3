#Requires AutoHotkey v2.0
#SingleInstance Force
{
    ClickAtCoord(1803, 919)     ;click the quest button
    Sleep(500)
    if(PixelSearch(&pX, &pY, 23, 817, 394, 859, 0x8C0B8D, 2))       ;check if the tower of titans event is active
    {
        ClickAtCoord(pX, pY)        ;click on the tower of titans quest
        Sleep(500)
        if(PixelSearch(&pX, &pY, 1673, 931, 1726, 975, 0x21F75D, 2))        ;check for climb to next floor button
        {
            ClickAtCoord(1700, 953)     ;click climb to next floor
            Sleep(500)
            if(PixelSearch(&pX, &pY, 1180, 743, 1213, 788, 0x21F75D, 2))       ;check for explore area
            {
                ClickAtCoord(1285, 763)     ;click explore area
                Sleep(500)
                RunWait("SubFunctions\General\ReturnToDefaultPos.ahk")
            }
        }
    }
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
}
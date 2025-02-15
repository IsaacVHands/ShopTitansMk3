#Requires AutoHotkey v2.0
#SingleInstance Force

{
    Sleep(1000)
    Send("{Alt Down}{F4}{Alt Up}")
    Sleep(10000)
    RunWait("steam://rungameid/1258080")
    Sleep(10000)
    ClickAtCoord(1849, -17)     ;maximize the game
    Sleep(1000)
}
ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
}
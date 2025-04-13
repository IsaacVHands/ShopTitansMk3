#Requires AutoHotkey v2.0
#SingleInstance Force
{
    ClickAtCoord(1686, 935)         ;collects an item
    loop(10)
    {
        Sleep(500)
        if(PixelSearch(&pX, &pY, 1647, 964, 1719, 997, 0xFFCB19, 3))        ;checks if an item is ready to be collected
        {
            ClickAtCoord(1686, 935)     ;collects an item
            Sleep(750)
            if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 1))      ;check if it was a quality item thus needing the collect button pushed
            {
                if(PixelSearch(&pX, &pY, 720, 736, 732, 750, 0x522C44, 3) or !PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 3))
                {
                    sleep(750)
                    ClickAtCoord(808, 747)
                    Sleep(500)
                }
            }
        }
    }
    sleep(250)
    if(PixelSearch(&pX, &pY, 1845, 851, 1875, 887, 0xFFBA29, 3))        ;check if there is a crafting slot available
    {
        RunWait("CraftQuick.ahk")
    }
}

ClickAtCoord(x, y)
{
    Click(x, y, "Left", "Down")
    Sleep(50)
    Click(x, y, "Left", "Up")
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

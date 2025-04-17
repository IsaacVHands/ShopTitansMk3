#Requires AutoHotkey v2.0
#Include ../../lib/helpers.ahk
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
            if(!PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 2))      ;check if it was a quality item thus needing the collect button pushed
            {
                if(PixelSearch(&pX, &pY, 720, 736, 732, 750, 0x522C44, 3) or !PixelSearch(&pX, &pY, 1848, 935, 1855, 943, 0x1E783F, 3))
                {
                    sleep(750)
                    ClickAtCoord(808, 747)
                    Sleep(500)
                }
            }
            if(PixelSearch(&pX, &pY, 998, 921, 1039, 961, 0x1EF65A, 2))         ;check for another blueprint discovered popup
            {
                ClickAtCoord(1110, 942)         ;click continue
                Sleep(500)
            }
            if(PixelSearch(&pX, &pY, 878, 932, 925, 959, 0x21F75F, 2))          ;check if research scrolls need to be collected
            {
                ClickAtCoord(pX, pY)            ;click ok
            }
        }
    }
    sleep(250)
    if(PixelSearch(&pX, &pY, 1845, 851, 1875, 887, 0xFFBA29, 3))        ;check if there is a crafting slot available
    {
        RunWait("CraftQuick.ahk")
    }
}
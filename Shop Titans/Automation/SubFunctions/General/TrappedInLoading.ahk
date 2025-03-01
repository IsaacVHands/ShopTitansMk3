#Requires AutoHotkey v2.0
#SingleInstance Force

{
    loadingScreen := false
    loop 4
    {
        if(PixelSearch(&pX, &pY, 272, 188, 352, 275, 0x000000, 2) and PixelSearch(&pX, &pY, 1561, 118, 1659, 194, 0x000000, 2) and PixelSearch(&pX, &pY, 145, 808, 224, 847, 0x000000, 2) and PixelSearch(&pX, &pY, 1707, 785, 1751, 815, 0xA5A6A5, 2))
        {
            loadingScreen := true
        }
        else
        {
            loadingScreen := false
            break
        }
        Sleep(5000)
    }
    if(loadingScreen)
    {
        RunWait("RestartShopTitans.ahk")
    }
}
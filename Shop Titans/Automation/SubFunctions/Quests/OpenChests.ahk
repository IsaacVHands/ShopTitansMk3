#Requires AutoHotkey v2.0
#include ../../../lib/helpers.ahk
#SingleInstance Force

Class OpenChests
{
    static openChestMenu()
    {
        if(PixelSearch(&pX, &pY, 361, 904, 393, 921, 0x30836D, 2))          ;check for chest tab
        {
            SendInput("3")
            Sleep(1000)
            return true
        }
        else
            return false
    }
    static unlockChests()
    {
        loop(100)
        {
            waitForEvent(750, 912, 870, 952, 0xFFFFFF, 50, 5000)
            if(PixelSearch(&pX, &pY, 750, 912, 870, 952, 0xFFFFFF, 3) and PixelSearch(&pX, &pY, 724, 915, 847, 954, 0xA77436, 3))          ;check for keys available and its a wooden chest
            {
                ClickAtCoord(811, 915)          ;open chest
                Sleep(500)
                ClickAtCoord(1821, 966)         ;click skip
                sleep(200)
                waitForEvent(931, 733, 963, 745, 0x16F352, 50, 10000)
                ClickAtCoord(963, 710)          ;click collect
                Sleep(250)
            }
            else
                break
        }
    }
    static closeChestMenu()
    {
        if(PixelSearch(&pX, &pY, 1696, 898, 1714, 913, 0x0EEFC7, 2))            ;check if quest menu is open
        {
            send("Escape")
            Sleep(1500)
        }
    }
}
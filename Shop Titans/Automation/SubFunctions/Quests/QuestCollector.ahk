#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../../../lib/helpers.ahk

class QuestCollector
{
    scan()
    {
        loop(20)
        {
            if(PixelSearch(&pX, &pY, 1097, 740, 1156, 780, 0x21F45A, 2))    ;check for level up
            {
                ClickAtCoord(1211, 758)     ;click continue
                Sleep(300)
            }
            Sleep(2000)
            if(PixelSearch(&pX, &pY, 852, 909, 893, 949, 0x21F75D, 2))    ;check for area level up
            {
                ClickAtCoord(958, 931)     ;click continue
                Sleep(300)
            }
            if(PixelSearch(&pX, &pY, 704, 734, 747, 763, 0x522C44, 2))      ;check for collect button
            {
                ClickAtCoord(895, 772)
                Sleep(5000)
                if(PixelSearch(&pX, &pY, 1861, 73, 1906, 115, 0xFF3E16, 3) and PixelSearch(&pX, &pY, 1861, 73, 1906, 115, 0xFFFFFF, 3))         ;check if event progress screen has popped up
                {
                    Send("{Escape}")
                }
                return true
            }
            else if(PixelSearch(&pX, &pY, 1114, 299, 1121, 323, 0xFFFFFF, 2))       ;if the quest complete words are in the upper middle
            {
                ClickAtCoord(162, 37)       ;click on nothing in the upper left
            }
            Sleep(1000)
        }
    }
}